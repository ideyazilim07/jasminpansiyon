import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { Save, Loader2, Check, Upload } from 'lucide-react'

const DEFAULTS = {
  restaurant_name: '', logo_url: '', whatsapp_number: '',
  address: '', instagram_url: '', default_language: 'tr', currency: 'TL',
}

export default function SettingsManager() {
  const [data, setData] = useState(DEFAULTS)
  const [rowId, setRowId] = useState(null)
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [saved, setSaved] = useState(false)
  const [uploading, setUploading] = useState(false)

  useEffect(() => {
    supabase.from('settings').select('*').limit(1).maybeSingle().then(({ data: row }) => {
      if (row) { setData({ ...DEFAULTS, ...row }); setRowId(row.id) }
      setLoading(false)
    })
  }, [])

  const set = (k, v) => setData(d => ({ ...d, [k]: v }))

  async function uploadLogo(e) {
    const file = e.target.files?.[0]
    if (!file) return
    setUploading(true)
    const name = `logo-${Date.now()}.${file.name.split('.').pop()}`
    const { data: d, error } = await supabase.storage.from('menu-images').upload(name, file, { upsert: true })
    if (!error && d) {
      const { data: u } = supabase.storage.from('menu-images').getPublicUrl(d.path)
      set('logo_url', u.publicUrl)
    }
    setUploading(false)
  }

  async function save() {
    setSaving(true); setSaved(false)
    const payload = { ...data, updated_at: new Date().toISOString() }
    delete payload.id
    const result = rowId
      ? await supabase.from('settings').update(payload).eq('id', rowId)
      : await supabase.from('settings').insert(payload).select().single()
    if (!rowId && !result.error) setRowId(result.data.id)
    setSaving(false); setSaved(true)
    setTimeout(() => setSaved(false), 3000)
  }

  if (loading) return <div className="flex justify-center py-12"><Loader2 size={28} className="animate-spin text-amber-500" /></div>

  const field = (label, key, props = {}) => (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-1.5">{label}</label>
      <input
        value={data[key] || ''}
        onChange={e => set(key, e.target.value)}
        className="w-full px-4 py-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400"
        {...props}
      />
    </div>
  )

  return (
    <div>
      <h2 className="text-xl font-bold text-gray-900 mb-6">Ayarlar</h2>
      <div className="bg-white rounded-2xl border border-gray-200 shadow-sm p-6 space-y-5 max-w-xl">
        {field('Restoran Adı', 'restaurant_name', { placeholder: 'Güneş Pansiyon' })}

        {/* Logo */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1.5">Logo</label>
          <div className="flex gap-3 items-center">
            {data.logo_url && (
              <img src={data.logo_url} alt="Logo" className="w-14 h-14 rounded-xl object-cover border border-gray-200 flex-shrink-0" />
            )}
            <div className="flex-1 space-y-2">
              <input
                value={data.logo_url || ''}
                onChange={e => set('logo_url', e.target.value)}
                placeholder="https://... (logo URL)"
                className="w-full px-4 py-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400"
              />
              <label className={`flex items-center gap-2 bg-gray-100 hover:bg-gray-200 text-gray-700 px-3 py-2 rounded-lg text-sm cursor-pointer w-fit ${uploading ? 'opacity-60 pointer-events-none' : ''}`}>
                {uploading ? <Loader2 size={13} className="animate-spin" /> : <Upload size={13} />}
                Logo Yükle
                <input type="file" accept="image/*" onChange={uploadLogo} className="hidden" disabled={uploading} />
              </label>
            </div>
          </div>
        </div>

        {field('WhatsApp Numarası', 'whatsapp_number', { placeholder: '905551234567 (ülke kodu dahil, boşluksuz)' })}
        {field('Adres', 'address', { placeholder: 'Restoran adresi' })}
        {field('Instagram URL', 'instagram_url', { placeholder: 'https://instagram.com/...' })}

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1.5">Varsayılan Dil</label>
          <select
            value={data.default_language}
            onChange={e => set('default_language', e.target.value)}
            className="w-full px-4 py-3 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-400 bg-white"
          >
            <option value="tr">Türkçe</option>
            <option value="en">English</option>
            <option value="ru">Русский</option>
          </select>
        </div>

        <button
          onClick={save}
          disabled={saving}
          className={`flex items-center gap-2 px-7 py-3 rounded-xl font-semibold text-sm transition-all ${saved ? 'bg-green-500 text-white' : 'bg-amber-500 hover:bg-amber-600 text-white'} disabled:opacity-70`}
        >
          {saving ? <Loader2 size={16} className="animate-spin" /> : saved ? <Check size={16} /> : <Save size={16} />}
          {saved ? 'Kaydedildi!' : saving ? 'Kaydediliyor...' : 'Kaydet'}
        </button>
      </div>
    </div>
  )
}
