import { useLanguage } from '../../contexts/LanguageContext'
import { Star, ImageOff } from 'lucide-react'

export default function ProductCard({ product }) {
  const { t, getName, getDesc } = useLanguage()
  const name = getName(product)
  const desc = getDesc(product)

  return (
    <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
      {/* Görsel — üstte tam genişlik */}
      <div className="relative w-full h-52">
        {product.image_url ? (
          <div className="w-full h-full bg-stone-100 flex items-center justify-center">
            <img
              src={product.image_url}
              alt={name}
              className="w-full h-full object-contain object-center"
              loading="lazy"
            />
          </div>
        ) : (
          <div className="w-full h-full bg-gradient-to-br from-amber-50 to-stone-100 flex items-center justify-center">
            <ImageOff size={40} className="text-amber-200" />
          </div>
        )}

        {/* Tükendi overlay */}
        {!product.is_active && (
          <div className="absolute inset-0 bg-gray-900/60 flex items-center justify-center">
            <span className="text-white text-sm font-bold bg-gray-800/80 px-4 py-1.5 rounded-full">
              {t('outOfStock')}
            </span>
          </div>
        )}

        {/* Öne çıkan rozeti */}
        {product.is_featured && (
          <div className="absolute top-3 left-3 flex items-center gap-1 bg-amber-500 text-white text-xs font-semibold px-2.5 py-1 rounded-full shadow">
            <Star size={11} className="fill-white" />
            {t('featured')}
          </div>
        )}
      </div>

      {/* İçerik — görselin altında */}
      <div className="px-4 py-3.5">
        <div className="flex items-start justify-between gap-2">
          <h3 className="font-semibold text-gray-900 text-base leading-snug flex-1">{name}</h3>
          <span className="text-amber-600 font-bold text-xl whitespace-nowrap">
            {Number(product.price).toLocaleString('tr-TR')}
            <span className="text-sm font-medium ml-0.5">{product.currency || 'TL'}</span>
          </span>
        </div>
        {desc && (
          <p className="text-gray-400 text-sm mt-1.5 leading-relaxed line-clamp-2">{desc}</p>
        )}
      </div>
    </div>
  )
}
