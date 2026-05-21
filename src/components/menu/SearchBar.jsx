import { Search, X } from 'lucide-react'
import { useLanguage } from '../../contexts/LanguageContext'

export default function SearchBar({ value, onChange }) {
  const { t } = useLanguage()
  return (
    <div className="relative">
      <Search size={15} className="absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" />
      <input
        type="search"
        value={value}
        onChange={e => onChange(e.target.value)}
        placeholder={t('search')}
        className="w-full pl-10 pr-9 py-2.5 bg-gray-100 rounded-xl text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-amber-400 focus:bg-white transition-all"
      />
      {value && (
        <button
          onClick={() => onChange('')}
          className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
        >
          <X size={15} />
        </button>
      )}
    </div>
  )
}
