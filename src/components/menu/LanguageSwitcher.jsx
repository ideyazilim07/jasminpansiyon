import { useLanguage } from '../../contexts/LanguageContext'

const LANGS = [
  { code: 'tr', label: 'TR' },
  { code: 'en', label: 'EN' },
  { code: 'ru', label: 'RU' },
]

export default function LanguageSwitcher() {
  const { language, setLanguage } = useLanguage()
  return (
    <div className="flex bg-white/10 rounded-lg p-0.5 gap-0.5">
      {LANGS.map(l => (
        <button
          key={l.code}
          onClick={() => setLanguage(l.code)}
          className={`px-2.5 py-1 rounded-md text-xs font-bold transition-all ${
            language === l.code
              ? 'bg-amber-500 text-white shadow-sm'
              : 'text-gray-300 hover:text-white'
          }`}
        >
          {l.label}
        </button>
      ))}
    </div>
  )
}
