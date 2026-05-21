import { useLanguage } from '../../contexts/LanguageContext'

export default function CategoryTabs({ categories, activeCategory, onSelect }) {
  const { t, getName } = useLanguage()

  return (
    <div className="flex gap-1.5 overflow-x-auto scrollbar-hide px-4 py-2.5" style={{ WebkitOverflowScrolling: 'touch' }}>
      <button
        onClick={() => onSelect('all')}
        className={`flex-shrink-0 px-4 py-1.5 rounded-full text-sm font-medium transition-all ${
          activeCategory === 'all'
            ? 'bg-amber-500 text-white shadow-sm'
            : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
        }`}
      >
        {t('allCategories')}
      </button>
      {categories.map(cat => (
        <button
          key={cat.id}
          onClick={() => onSelect(cat.id)}
          className={`flex-shrink-0 px-4 py-1.5 rounded-full text-sm font-medium transition-all whitespace-nowrap ${
            activeCategory === cat.id
              ? 'bg-amber-500 text-white shadow-sm'
              : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
          }`}
        >
          {getName(cat)}
        </button>
      ))}
    </div>
  )
}
