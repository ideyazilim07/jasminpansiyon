import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { Plus, Edit2, Trash2, ChevronUp, ChevronDown, Star, Loader2, ToggleLeft, ToggleRight } from 'lucide-react'
import ProductForm from './ProductForm'

export default function ProductManager() {
  const [products, setProducts] = useState([])
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [catFilter, setCatFilter] = useState('all')
  const [showForm, setShowForm] = useState(false)
  const [editing, setEditing] = useState(null)

  useEffect(() => { load() }, [])

  async function load() {
    const [p, c] = await Promise.all([
      supabase.from('products').select('*').order('category_id').order('sort_order'),
      supabase.from('categories').select('*').order('sort_order'),
    ])
    if (!p.error) setProducts(p.data ?? [])
    if (!c.error) setCategories(c.data ?? [])
    setLoading(false)
  }

  async function remove(id) {
    if (!confirm('Bu ürünü silmek istediğinize emin misiniz?')) return
    await supabase.from('products').delete().eq('id', id)
    await load()
  }

  async function toggleActive(prod) {
    await supabase.from('products').update({ is_active: !prod.is_active }).eq('id', prod.id)
    await load()
  }

  async function toggleFeatured(prod) {
    await supabase.from('products').update({ is_featured: !prod.is_featured }).eq('id', prod.id)
    await load()
  }

  async function reorder(id, dir) {
    const catId = products.find(p => p.id === id)?.category_id
    const catProds = products.filter(p => p.category_id === catId)
    const idx = catProds.findIndex(p => p.id === id)
    const swap = dir === 'up' ? idx - 1 : idx + 1
    if (swap < 0 || swap >= catProds.length) return
    await Promise.all([
      supabase.from('products').update({ sort_order: catProds[swap].sort_order }).eq('id', catProds[idx].id),
      supabase.from('products').update({ sort_order: catProds[idx].sort_order }).eq('id', catProds[swap].id),
    ])
    await load()
  }

  const catName = id => categories.find(c => c.id === id)?.name_tr ?? '—'
  const visible = catFilter === 'all' ? products : products.filter(p => p.category_id === catFilter)

  if (loading) return <div className="flex justify-center py-12"><Loader2 size={28} className="animate-spin text-amber-500" /></div>

  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-xl font-bold text-gray-900">Ürünler <span className="text-gray-400 font-normal text-base">({visible.length})</span></h2>
        <button
          onClick={() => { setEditing(null); setShowForm(true) }}
          className="flex items-center gap-2 bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-xl text-sm font-medium transition-colors"
        >
          <Plus size={15} /> Yeni Ürün
        </button>
      </div>

      {/* Kategori filtresi */}
      <div className="flex gap-1.5 overflow-x-auto scrollbar-hide pb-2 mb-4">
        <button
          onClick={() => setCatFilter('all')}
          className={`flex-shrink-0 px-3 py-1.5 rounded-lg text-xs font-medium transition-colors ${catFilter === 'all' ? 'bg-amber-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}
        >Tümü</button>
        {categories.map(cat => (
          <button
            key={cat.id}
            onClick={() => setCatFilter(cat.id)}
            className={`flex-shrink-0 px-3 py-1.5 rounded-lg text-xs font-medium transition-colors whitespace-nowrap ${catFilter === cat.id ? 'bg-amber-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}
          >{cat.name_tr}</button>
        ))}
      </div>

      <div className="space-y-2">
        {visible.map(prod => {
          const catProds = visible.filter(p => p.category_id === prod.category_id)
          const ci = catProds.findIndex(p => p.id === prod.id)
          return (
            <div key={prod.id} className={`bg-white rounded-xl border shadow-sm ${prod.is_active ? 'border-gray-200' : 'border-gray-100'}`}>
              <div className="flex items-center gap-2 px-3 py-2.5">
                {/* Sıralama */}
                <div className="flex flex-col flex-shrink-0">
                  <button onClick={() => reorder(prod.id,'up')} disabled={ci===0} className="text-gray-300 hover:text-gray-600 disabled:opacity-20"><ChevronUp size={14} /></button>
                  <button onClick={() => reorder(prod.id,'down')} disabled={ci===catProds.length-1} className="text-gray-300 hover:text-gray-600 disabled:opacity-20"><ChevronDown size={14} /></button>
                </div>

                {/* Görsel */}
                {prod.image_url
                  ? <img src={prod.image_url} alt={prod.name_tr} className="w-11 h-11 rounded-lg object-cover flex-shrink-0" />
                  : <div className="w-11 h-11 bg-amber-50 rounded-lg flex-shrink-0 border border-amber-100" />
                }

                {/* Bilgi */}
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-1">
                    <p className={`font-medium text-sm truncate ${prod.is_active ? 'text-gray-900' : 'text-gray-400'}`}>{prod.name_tr}</p>
                    {prod.is_featured && <Star size={11} className="text-amber-500 fill-amber-500 flex-shrink-0" />}
                  </div>
                  <p className="text-[11px] text-gray-400">{catName(prod.category_id)}</p>
                  <p className="text-amber-600 font-semibold text-sm">{Number(prod.price).toLocaleString('tr-TR')} TL</p>
                </div>

                {/* Aksiyonlar */}
                <div className="flex items-center gap-0.5 flex-shrink-0">
                  <button onClick={() => toggleFeatured(prod)} className={`p-1.5 rounded-lg ${prod.is_featured ? 'text-amber-500 bg-amber-50' : 'text-gray-300 hover:text-amber-400 hover:bg-amber-50'}`} title="Öne Çıkar">
                    <Star size={14} />
                  </button>
                  <button onClick={() => toggleActive(prod)} className={`p-1.5 rounded-lg ${prod.is_active ? 'text-green-500 hover:bg-green-50' : 'text-gray-300 hover:bg-gray-100'}`}>
                    {prod.is_active ? <ToggleRight size={18} /> : <ToggleLeft size={18} />}
                  </button>
                  <button onClick={() => { setEditing(prod); setShowForm(true) }} className="p-1.5 text-gray-400 hover:text-amber-600 hover:bg-amber-50 rounded-lg">
                    <Edit2 size={14} />
                  </button>
                  <button onClick={() => remove(prod.id)} className="p-1.5 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg">
                    <Trash2 size={14} />
                  </button>
                </div>
              </div>
            </div>
          )
        })}
      </div>

      {visible.length === 0 && <p className="text-center text-gray-400 py-10">Bu kategoride ürün yok.</p>}

      {showForm && (
        <ProductForm
          product={editing}
          categories={categories}
          onClose={() => { setShowForm(false); setEditing(null) }}
          onSave={async () => { setShowForm(false); setEditing(null); await load() }}
        />
      )}
    </div>
  )
}
