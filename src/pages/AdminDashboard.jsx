import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import CategoryManager from '../components/admin/CategoryManager'
import ProductManager from '../components/admin/ProductManager'
import QRGenerator from '../components/admin/QRGenerator'
import SettingsManager from '../components/admin/SettingsManager'
import { UtensilsCrossed, Package, LayoutGrid, QrCode, Settings, LogOut } from 'lucide-react'

const TABS = [
  { id: 'products',    label: 'Ürünler',    Icon: Package },
  { id: 'categories', label: 'Kategoriler', Icon: LayoutGrid },
  { id: 'qr',         label: 'QR Kod',      Icon: QrCode },
  { id: 'settings',   label: 'Ayarlar',     Icon: Settings },
]

export default function AdminDashboard() {
  const [tab, setTab] = useState('products')
  const { user, signOut } = useAuth()
  const navigate = useNavigate()

  const handleSignOut = async () => {
    await signOut()
    navigate('/admin')
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-gray-900 text-white shadow-lg">
        <div className="max-w-4xl mx-auto px-4 py-3 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 bg-amber-500 rounded-lg flex items-center justify-center">
              <UtensilsCrossed size={16} className="text-white" />
            </div>
            <div>
              <p className="font-bold">Admin Panel</p>
              <p className="text-gray-400 text-xs leading-none">{user?.email}</p>
            </div>
          </div>
          <button
            onClick={handleSignOut}
            className="flex items-center gap-1.5 text-gray-400 hover:text-white text-sm transition-colors"
          >
            <LogOut size={15} />
            Çıkış
          </button>
        </div>
      </header>

      {/* Tab bar */}
      <div className="bg-white border-b border-gray-200 sticky top-0 z-40 shadow-sm">
        <div className="max-w-4xl mx-auto px-4">
          <div className="flex overflow-x-auto scrollbar-hide">
            {TABS.map(({ id, label, Icon }) => (
              <button
                key={id}
                onClick={() => setTab(id)}
                className={`flex items-center gap-2 px-4 py-3.5 text-sm font-medium border-b-2 transition-all whitespace-nowrap ${
                  tab === id
                    ? 'border-amber-500 text-amber-600'
                    : 'border-transparent text-gray-500 hover:text-gray-700'
                }`}
              >
                <Icon size={16} />
                {label}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-4xl mx-auto px-4 py-6">
        {tab === 'products'    && <ProductManager />}
        {tab === 'categories'  && <CategoryManager />}
        {tab === 'qr'          && <QRGenerator />}
        {tab === 'settings'    && <SettingsManager />}
      </div>
    </div>
  )
}
