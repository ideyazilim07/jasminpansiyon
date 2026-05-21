import { useState, useEffect, useMemo } from 'react'
import { supabase } from '../lib/supabase'
import { useLanguage } from '../contexts/LanguageContext'
import CategoryTabs from '../components/menu/CategoryTabs'
import ProductCard from '../components/menu/ProductCard'
import SearchBar from '../components/menu/SearchBar'
import LanguageSwitcher from '../components/menu/LanguageSwitcher'
import { UtensilsCrossed } from 'lucide-react'

export default function MenuPage() {
  const [categories, setCategories] = useState([])
  const [products, setProducts] = useState([])
  const [settings, setSettings] = useState({ restaurant_name: 'Güneş Pansiyon' })
  const [activeCategory, setActiveCategory] = useState('all')
  const [searchQuery, setSearchQuery] = useState('')
  const [loading, setLoading] = useState(true)
  const { t, getName } = useLanguage()

  useEffect(() => {
    async function load() {
      const [cats, prods, cfg] = await Promise.all([
        supabase.from('categories').select('*').eq('is_active', true).order('sort_order'),
        supabase.from('products').select('*').eq('is_active', true).order('sort_order'),
        supabase.from('settings').select('*').limit(1).maybeSingle(),
      ])
      if (!cats.error) setCategories(cats.data ?? [])
      if (!prods.error) setProducts(prods.data ?? [])
      if (!cfg.error && cfg.data) setSettings(cfg.data)
      setLoading(false)
    }
    load()
  }, [])

  const filtered = useMemo(() => {
    let list = products
    if (activeCategory !== 'all') list = list.filter(p => p.category_id === activeCategory)
    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase()
      list = list.filter(p =>
        p.name_tr?.toLowerCase().includes(q) ||
        p.name_en?.toLowerCase().includes(q) ||
        p.name_ru?.toLowerCase().includes(q) ||
        p.description_tr?.toLowerCase().includes(q)
      )
    }
    // Tümü görünümünde: önce kategori sırası, sonra ürün sırası
    if (activeCategory === 'all') {
      const catOrder = Object.fromEntries(categories.map(c => [c.id, c.sort_order]))
      list = [...list].sort((a, b) => {
        const catDiff = (catOrder[a.category_id] ?? 99) - (catOrder[b.category_id] ?? 99)
        return catDiff !== 0 ? catDiff : (a.sort_order ?? 0) - (b.sort_order ?? 0)
      })
    }
    return list
  }, [products, activeCategory, searchQuery, categories])

  if (loading) {
    return (
      <div className="min-h-screen bg-stone-50 flex items-center justify-center">
        <div className="text-center">
          <div className="w-10 h-10 border-4 border-amber-400 border-t-transparent rounded-full animate-spin mx-auto mb-3" />
          <p className="text-gray-400 text-sm">Yükleniyor...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-stone-50">
      {/* Header */}
      <header className="bg-gradient-to-r from-gray-900 via-gray-800 to-gray-900 text-white sticky top-0 z-50 shadow-lg">
        <div className="max-w-lg mx-auto px-4 py-3 flex items-center justify-between">
          <div className="flex items-center gap-2.5">
            {settings.logo_url ? (
              <img src={settings.logo_url} alt="Logo" className="h-10 w-10 rounded-full object-cover border-2 border-amber-500/40" />
            ) : (
              <div className="w-10 h-10 rounded-full bg-amber-500 flex items-center justify-center shadow">
                <UtensilsCrossed size={18} className="text-white" />
              </div>
            )}
            <div>
              <h1 className="font-bold text-lg leading-tight">{settings.restaurant_name}</h1>
              <p className="text-amber-400 text-xs font-medium tracking-wide">{t('menu')}</p>
            </div>
          </div>
          <LanguageSwitcher />
        </div>
      </header>

      {/* Search */}
      <div className="bg-white border-b border-gray-100 shadow-sm">
        <div className="max-w-lg mx-auto px-4 py-3">
          <SearchBar value={searchQuery} onChange={setSearchQuery} />
        </div>
      </div>

      {/* Category Tabs */}
      {!searchQuery && (
        <div className="bg-white border-b border-gray-200 shadow-sm">
          <CategoryTabs
            categories={categories}
            activeCategory={activeCategory}
            onSelect={setActiveCategory}
          />
        </div>
      )}

      {/* Product List */}
      <main className="max-w-lg mx-auto px-3 py-4 pb-10">
        {filtered.length === 0 ? (
          <div className="text-center py-20 text-gray-400">
            <UtensilsCrossed size={44} className="mx-auto mb-4 opacity-20" />
            <p className="text-base font-medium">{searchQuery ? t('noResults') : t('noProducts')}</p>
          </div>
        ) : (
          <div className="grid grid-cols-2 gap-3">
            {filtered.map(product => (
              <ProductCard key={product.id} product={product} />
            ))}
          </div>
        )}
      </main>

      {/* Footer links */}
      {(settings.whatsapp_number || settings.instagram_url || settings.address) && (
        <footer className="max-w-lg mx-auto px-4 py-5 border-t border-gray-200 text-center space-y-1">
          <div className="flex justify-center gap-5">
            {settings.whatsapp_number && (
              <a
                href={`https://wa.me/${settings.whatsapp_number.replace(/\D/g, '')}`}
                className="text-green-600 text-sm font-medium"
                target="_blank" rel="noopener noreferrer"
              >
                WhatsApp
              </a>
            )}
            {settings.instagram_url && (
              <a
                href={settings.instagram_url}
                className="text-pink-600 text-sm font-medium"
                target="_blank" rel="noopener noreferrer"
              >
                Instagram
              </a>
            )}
          </div>
          {settings.address && (
            <p className="text-gray-400 text-xs">{settings.address}</p>
          )}
        </footer>
      )}
    </div>
  )
}
