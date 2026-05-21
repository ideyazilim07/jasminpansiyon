import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { Plus, Edit2, Trash2, ChevronUp, ChevronDown, Check, X, Loader2, ToggleLeft, ToggleRight } from 'lucide-react'

const emptyForm = { name_tr: '', name_en: '', name_ru: '' }

function slug(text) {
  return text.toLowerCase()
    .replace(/ğ/g,'g').replace(/ü/g,'u').replace(/ş/g,'s')
    .replace(/ı/g,'i').replace(/ö/g,'o').replace(/ç/g,'c')
    .replace(/[^a-z0-9]+/g,'-').replace(/^-|-$/g,'')
}

export default function CategoryManager() {
  const [cats, setCats] = useState([])
  const [loading, setLoading] = useState(true)
  const [editId, setEditId] = useState(null)
  const [editForm, setEditForm] = useState({})
  const [adding, setAdding] = useState(false)
  const [newForm, setNewForm] = useState(emptyForm)
  const [busy, setBusy] = useState(false)

  useEffect(() => { fetch() }, [])

  async function fetch() {
    const { data } = await supabase.from('categories').select('*').order('sort_order')
    setCats(data ?? [])
    setLoading(false)
  }

  async function add() {
    if (!newForm.name_tr.trim()) return
    setBusy(true)
    const maxOrder = cats.length ? Math.max(...cats.map(c => c.sort_order)) + 1 : 0
    await supabase.from('categories').insert({
      ...newForm,
      slug: slug(newForm.name_tr),
      sort_order: maxOrder,
    })
    setNewForm(emptyForm); setAdding(false)
    await fetch(); setBusy(false)
  }

  async function save(id) {
    setBusy(true)
    await supabase.from('categories').update(editForm).eq('id', id)
    setEditId(null); await fetch(); setBusy(false)
  }

  async function remove(id) {
    if (!confirm('Bu kategoriyi ve tüm ürünlerini silmek istiyor musunuz?')) return
    await supabase.from('categories').delete().eq('id', id)
    await fetch()
  }

  async function toggle(cat) {
    await supabase.from('categories').update({ is_active: !cat.is_active }).eq('id', cat.id)
    await fetch()
  }

  async function reorder(id, dir) {
    const idx = cats.findIndex(c => c.id === id)
    const swap = dir === 'up' ? idx - 1 : idx + 1
    if (swap < 0 || swap >= cats.length) return
    await Promise.all([
      supabase.from('categories').update({ sort_order: cats[swap].sort_order }).eq('id', cats[idx].id),
      supabase.from('categories').update({ sort_order: cats[idx].sort_order }).eq('id', cats[swap].id),
    ])
    await fetch()
  }

  if (loading) return <div className="flex justify-center py-12"><Loader2 size={28} className="animate-spin text-amber-500" /></div>

  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-xl font-bold text-gray-900">Kategoriler</h2>
        <button
          onClick={() => setAdding(true)}
          className="flex items-center gap-2 bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-xl text-sm font-medium transition-colors"
        >
          <Plus size={15} /> Yeni Kategori
        </button>
      </div>

      {adding && (
        <div className="bg-amber-50 border border-amber-200 rounded-2xl p-4 mb-4">
          <p className="text-sm font-semibold text-gray-800 mb-3">Yeni Kategori</p>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-2 mb-3">
            {[['tr','Türkçe *'],['en','İngilizce'],['ru','Rusça']].map(([lang, lbl]) => (
              <div key={lang}>
                <label className="block text-xs text-gray-500 mb-1">{lbl}</label>
                <input
                  value={newForm[`name_${lang}`]}
                  onChange={e => setNewForm(f => ({ ...f, [`name_${lang}`]: e.target.value }))}
                  placeholder={lbl}
                  className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-400"
                />
              </div>
            ))}
          </div>
          <div className="flex gap-2">
            <button onClick={add} disabled={busy || !newForm.name_tr}
              className="flex items-center gap-1.5 bg-amber-500 hover:bg-amber-600 disabled:opacity-60 text-white px-4 py-2 rounded-lg text-sm font-medium">
              {busy ? <Loader2 size={13} className="animate-spin" /> : <Check size={13} />} Ekle
            </button>
            <button onClick={() => { setAdding(false); setNewForm(emptyForm) }}
              className="flex items-center gap-1.5 bg-white hover:bg-gray-100 text-gray-700 border border-gray-200 px-4 py-2 rounded-lg text-sm font-medium">
              <X size={13} /> İptal
            </button>
          </div>
        </div>
      )}

      <div className="space-y-2">
        {cats.map((cat, i) => (
          <div key={cat.id} className={`bg-white rounded-xl border shadow-sm ${cat.is_active ? 'border-gray-200' : 'border-gray-100 opacity-60'}`}>
            {editId === cat.id ? (
              <div className="p-4">
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-2 mb-3">
                  {[['tr','Türkçe'],['en','İngilizce'],['ru','Rusça']].map(([lang, lbl]) => (
                    <div key={lang}>
                      <label className="block text-xs text-gray-500 mb-1">{lbl}</label>
                      <input
                        value={editForm[`name_${lang}`] || ''}
                        onChange={e => setEditForm(f => ({ ...f, [`name_${lang}`]: e.target.value }))}
                        className="w-full px-3 py-2 border border-gray-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-400"
                      />
                    </div>
                  ))}
                </div>
                <div className="flex gap-2">
                  <button onClick={() => save(cat.id)} disabled={busy}
                    className="flex items-center gap-1.5 bg-amber-500 text-white px-3 py-1.5 rounded-lg text-sm font-medium">
                    {busy ? <Loader2 size={13} className="animate-spin" /> : <Check size={13} />} Kaydet
                  </button>
                  <button onClick={() => setEditId(null)}
                    className="flex items-center gap-1.5 bg-gray-100 text-gray-700 px-3 py-1.5 rounded-lg text-sm font-medium">
                    <X size={13} /> İptal
                  </button>
                </div>
              </div>
            ) : (
              <div className="flex items-center justify-between px-3 py-3 gap-3">
                <div className="flex items-center gap-3 min-w-0">
                  <div className="flex flex-col">
                    <button onClick={() => reorder(cat.id,'up')} disabled={i===0} className="text-gray-300 hover:text-gray-600 disabled:opacity-20"><ChevronUp size={14} /></button>
                    <button onClick={() => reorder(cat.id,'down')} disabled={i===cats.length-1} className="text-gray-300 hover:text-gray-600 disabled:opacity-20"><ChevronDown size={14} /></button>
                  </div>
                  <div className="min-w-0">
                    <p className="font-medium text-gray-900 text-sm">{cat.name_tr}</p>
                    <p className="text-xs text-gray-400 truncate">{cat.name_en} · {cat.name_ru}</p>
                  </div>
                </div>
                <div className="flex items-center gap-1 flex-shrink-0">
                  <button onClick={() => toggle(cat)} className={`p-1.5 rounded-lg ${cat.is_active ? 'text-green-500 hover:bg-green-50' : 'text-gray-300 hover:bg-gray-100'}`}>
                    {cat.is_active ? <ToggleRight size={20} /> : <ToggleLeft size={20} />}
                  </button>
                  <button onClick={() => { setEditId(cat.id); setEditForm(cat) }} className="p-1.5 text-gray-400 hover:text-amber-600 hover:bg-amber-50 rounded-lg">
                    <Edit2 size={15} />
                  </button>
                  <button onClick={() => remove(cat.id)} className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg">
                    <Trash2 size={15} />
                  </button>
                </div>
              </div>
            )}
          </div>
        ))}
      </div>

      {cats.length === 0 && <p className="text-center text-gray-400 py-10">Henüz kategori yok.</p>}
    </div>
  )
}
