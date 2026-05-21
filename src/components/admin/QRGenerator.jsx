import { useState, useEffect } from 'react'
import { Download, Copy, Check, Link } from 'lucide-react'
import QRCode from 'qrcode'

export default function QRGenerator() {
  const [url, setUrl] = useState('')
  const [qrSrc, setQrSrc] = useState('')
  const [copied, setCopied] = useState(false)

  useEffect(() => {
    const menuUrl = `${window.location.origin}/`
    setUrl(menuUrl)
    generate(menuUrl)
  }, [])

  async function generate(target) {
    try {
      const dataUrl = await QRCode.toDataURL(target, {
        width: 400, margin: 2,
        errorCorrectionLevel: 'H',
        color: { dark: '#1A1A1A', light: '#FFFFFF' },
      })
      setQrSrc(dataUrl)
    } catch {}
  }

  function download() {
    const a = document.createElement('a')
    a.href = qrSrc
    a.download = 'menu-qr-kod.png'
    a.click()
  }

  async function copy() {
    await navigator.clipboard.writeText(url)
    setCopied(true)
    setTimeout(() => setCopied(false), 2000)
  }

  return (
    <div>
      <h2 className="text-xl font-bold text-gray-900 mb-6">QR Kod</h2>

      <div className="bg-white rounded-2xl border border-gray-200 shadow-sm p-6 max-w-md">
        {/* QR Kod */}
        {qrSrc && (
          <div className="flex justify-center mb-6">
            <div className="p-3 border-2 border-gray-200 rounded-2xl shadow-inner inline-block">
              <img src={qrSrc} alt="QR Kod" className="w-56 h-56" />
            </div>
          </div>
        )}

        {/* URL */}
        <div className="mb-5">
          <label className="block text-sm font-medium text-gray-700 mb-2 flex items-center gap-1.5">
            <Link size={14} /> Menü Linki
          </label>
          <div className="flex gap-2">
            <input
              type="url"
              value={url}
              onChange={e => { setUrl(e.target.value); generate(e.target.value) }}
              className="flex-1 px-4 py-2.5 border border-gray-200 rounded-xl text-sm font-mono text-gray-700 focus:outline-none focus:ring-2 focus:ring-amber-400 min-w-0"
            />
            <button
              onClick={copy}
              className={`flex items-center gap-1.5 px-4 py-2.5 rounded-xl text-sm font-medium transition-all whitespace-nowrap ${copied ? 'bg-green-100 text-green-700' : 'bg-gray-100 hover:bg-gray-200 text-gray-700'}`}
            >
              {copied ? <Check size={14} /> : <Copy size={14} />}
              {copied ? 'Kopyalandı!' : 'Kopyala'}
            </button>
          </div>
        </div>

        {/* İndir */}
        <button
          onClick={download}
          disabled={!qrSrc}
          className="w-full flex items-center justify-center gap-2 bg-amber-500 hover:bg-amber-600 disabled:opacity-60 text-white px-6 py-3 rounded-xl font-semibold transition-colors"
        >
          <Download size={18} />
          QR Kodu PNG İndir
        </button>

        <p className="text-gray-400 text-xs text-center mt-4 leading-relaxed">
          Bu QR kodu masalara koyarak müşterilerinizin menünüze kolayca ulaşmasını sağlayın.
        </p>
      </div>
    </div>
  )
}
