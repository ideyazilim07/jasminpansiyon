import { createContext, useContext, useState } from 'react'

const LanguageContext = createContext()

const translations = {
  tr: {
    search: 'Ürün ara...',
    allCategories: 'Tümü',
    featured: 'Öne Çıkan',
    outOfStock: 'Tükendi',
    noProducts: 'Bu kategoride ürün bulunamadı',
    noResults: 'Arama sonucu bulunamadı',
    menu: 'Menü',
  },
  en: {
    search: 'Search menu...',
    allCategories: 'All',
    featured: 'Featured',
    outOfStock: 'Out of Stock',
    noProducts: 'No products in this category',
    noResults: 'No results found',
    menu: 'Menu',
  },
  ru: {
    search: 'Поиск...',
    allCategories: 'Все',
    featured: 'Рекомендуем',
    outOfStock: 'Нет в наличии',
    noProducts: 'Нет блюд в этой категории',
    noResults: 'Ничего не найдено',
    menu: 'Меню',
  },
}

export function LanguageProvider({ children }) {
  const [language, setLanguage] = useState('tr')

  const t = (key) => translations[language]?.[key] || translations.tr[key] || key

  const getName = (obj) => obj?.[`name_${language}`] || obj?.name_tr || ''
  const getDesc = (obj) => obj?.[`description_${language}`] || obj?.description_tr || ''

  return (
    <LanguageContext.Provider value={{ language, setLanguage, t, getName, getDesc }}>
      {children}
    </LanguageContext.Provider>
  )
}

export function useLanguage() {
  const ctx = useContext(LanguageContext)
  if (!ctx) throw new Error('useLanguage must be inside LanguageProvider')
  return ctx
}
