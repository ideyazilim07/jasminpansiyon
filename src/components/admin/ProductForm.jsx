import { useState } from 'react'
import { supabase } from '../../lib/supabase'
import { X, Upload, Loader2, Check } from 'lucide-react'

const BLANK = {
  category_id: '', price: '', currency: 'TL',
  name_tr: '', name_en: '', name_ru: '',
  description_tr: '', description_en: '', description_ru: '',
  image_url: '', is_active: true, is_featured: false, sort_order: 0,
}

const LANG_LABELS = { tr: 'Türkçe', en: 'English', ru: 'Русский' }

export default function ProductForm({ product, categories, onClose, onSave }) {
  const [form, setForm] = useState(product ? { ...BLANK, ...product } : { ...BLANK })
  const [langTab, setLangTab] = useState('tr')
  const [saving, setSaving] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState('')

  const set = (k, v) => setForm(f => ({ ...f, [k]: v }))

  async function uploadImage(e) {
    const file = e.target.files?.[0]
    if (!file) return
    setUploading(true)
    const name = `${Date.now()}-${file.name.replace(/[^a-z0-9.]/gi, '_')}`
    const { data, error: err } = await supabase.storage.from('menu-images').upload(name, file, { upsert: true })
    if (!err && data) {
      const { data: u } = supabase.storage.from('menu-images').getPublicUrl(data.path)
      set('image_url', u.publicUrl)
    } else {
      setError(`Görsel yüklenemedi: ${err?.message || 'Bilinmeyen hata'}. Supabase SQL Editor'da supabase/storage.sql dosyasını çalıştırın.`)
    }
    setUploading(false)
  }

  async function submit(e) {
    e.preventDefault()
    if (!form.name_tr.trim() || !form.price || !form.category_id) {
      setError('Türkçe ad, fiyat ve kategori zorunludur.')
      return
    }
    setSaving(true)
    setError('')
    const payload = {
      ...form,
      price: parseFloat(form.price),
      sort_order: parseInt(form.sort_order) || 0,
      updated_at: new Date().toISOString(),
    }
    const result = product?.id
      ? await supabase.from('products').update(payload).eq('id', product.id)
      : await supabase.from('products').insert(payload)

    if (result.error) {
      setError('Kaydedilemedi: ' + result.error.message)
      setSaving(false)
    } else {
      await onSave()
    }
  }

  return (
    <div className="fixed inset-0 bg-black/60 z-50 flex items-end sm:items-center justify-center">
      <div className="bg-white w-full sm:max-w-2xl sm:rounded-2xl rounded-t-2xl max-h-[92vh] overflow-y-auto shadow-2xl">
        {/* Başlık */}
        <div className="flex items-center justify-between px-5 py-4 border-b border-gray-100 sticky top-0 bg-white z-10">
          <h3 className="font-bold text-gray-900 text-lg">
            {product ? 'Ürünü Düzenle' : 'Yeni Ürün Ekle'}
          </h3>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-lg text-gray-500">
            <X size={18} />
          </button>
        </div>

        <form onSubmit={submit} className="p-5 space-y-5">
          {/* Kategori + Fiyat */}
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1.5">Kategori *</label>
              <select
                value={form.category_id}
                onChange={e => set('category_id', e.target.value)}
                required
                className="w-full px-3 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400 bg-white"
              >
                <option value="">Seçin...</option>
                {categories.map(c => <option key={c.id} value={c.id}>{c.name_tr}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1.5">Fiyat (TL) *</label>
              <input
                type="number" min="0" step="1"
                value={form.price}
                onChange={e => set('price', e.target.value)}
                required placeholder="0"
                className="w-full px-3 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400"
              />
            </div>
          </div>

          {/* Dil sekmeleri */}
          <div>
            <div className="flex border-b border-gray-200 mb-4">
              {['tr','en','ru'].map(lang => (
                <button key={lang} type="button" onClick={() => setLangTab(lang)}
                  className={`px-5 py-2.5 text-sm font-medium border-b-2 transition-all ${langTab===lang ? 'border-amber-500 text-amber-600' : 'border-transparent text-gray-500 hover:text-gray-700'}`}>
                  {LANG_LABELS[lang]}
                </button>
              ))}
            </div>
            <div className="space-y-3">
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1.5">
                  Ürün Adı {langTab==='tr' && <span className="text-red-500">*</span>}
                </label>
                <input
                  value={form[`name_${langTab}`] || ''}
                  onChange={e => set(`name_${langTab}`, e.target.value)}
                  required={langTab==='tr'}
                  placeholder={`Ürün adı (${LANG_LABELS[langTab]})`}
                  className="w-full px-3 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400"
                />
              </div>
              <div>
                <label className="block text-xs font-medium text-gray-600 mb-1.5">Açıklama</label>
                <textarea
                  value={form[`description_${langTab}`] || ''}
                  onChange={e => set(`description_${langTab}`, e.target.value)}
                  placeholder={`Kısa açıklama (${LANG_LABELS[langTab]})`}
                  rows={3}
                  className="w-full px-3 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400 resize-none"
                />
              </div>
            </div>
          </div>

          {/* Görsel */}
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1.5">Ürün Görseli</label>
            <div className="flex gap-3 items-start">
              {form.image_url && (
                <div className="relative flex-shrink-0">
                  <img src={form.image_url} alt="" className="w-20 h-20 object-cover rounded-xl border border-gray-200" />
                  <button type="button" onClick={() => set('image_url','')}
                    className="absolute -top-1.5 -right-1.5 bg-gray-800 text-white rounded-full w-5 h-5 flex items-center justify-center text-xs">
                    ×
                  </button>
                </div>
              )}
              <div className="flex-1 space-y-2">
                <input
                  type="url"
                  value={form.image_url || ''}
                  onChange={e => set('image_url', e.target.value)}
                  placeholder="https://... (görsel URL)"
                  className="w-full px-3 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400"
                />
                <label className={`flex items-center gap-2 bg-gray-100 hover:bg-gray-200 text-gray-700 px-3 py-2 rounded-lg text-sm cursor-pointer w-fit transition-colors ${uploading ? 'opacity-60 pointer-events-none' : ''}`}>
                  {uploading ? <Loader2 size={13} className="animate-spin" /> : <Upload size={13} />}
                  {uploading ? 'Yükleniyor...' : 'Dosyadan Yükle'}
                  <input type="file" accept="image/*" onChange={uploadImage} className="hidden" disabled={uploading} />
                </label>
              </div>
            </div>
          </div>

          {/* Toggle'lar */}
          <div className="flex gap-6">
            {[
              { key: 'is_active', label: 'Aktif (stokta var)', on: 'bg-green-500', off: 'bg-gray-300' },
              { key: 'is_featured', label: 'Öne Çıkan', on: 'bg-amber-500', off: 'bg-gray-300' },
            ].map(({ key, label, on, off }) => (
              <label key={key} className="flex items-center gap-2.5 cursor-pointer select-none">
                <div
                  role="switch"
                  aria-checked={form[key]}
                  onClick={() => set(key, !form[key])}
                  className={`w-10 h-5 rounded-full relative transition-colors ${form[key] ? on : off}`}
                >
                  <div className={`w-4 h-4 rounded-full bg-white shadow absolute top-0.5 transition-all ${form[key] ? 'left-5' : 'left-0.5'}`} />
                </div>
                <span className="text-sm text-gray-700">{label}</span>
              </label>
            ))}
          </div>

          {error && (
            <div className="bg-red-50 border border-red-200 rounded-xl px-4 py-3 text-red-700 text-sm">
              {error}
            </div>
          )}

          <div className="flex gap-3 pt-1">
            <button type="submit" disabled={saving}
              className="flex-1 flex items-center justify-center gap-2 bg-amber-500 hover:bg-amber-600 disabled:opacity-70 text-white font-semibold py-3 rounded-xl transition-colors">
              {saving ? <Loader2 size={17} className="animate-spin" /> : <Check size={17} />}
              {product ? 'Güncelle' : 'Ürün Ekle'}
            </button>
            <button type="button" onClick={onClose}
              className="flex-1 bg-gray-100 hover:bg-gray-200 text-gray-700 font-semibold py-3 rounded-xl transition-colors">
              İptal
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
