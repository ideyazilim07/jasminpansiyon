-- ============================================================
-- Dijital QR Menü — Veritabanı Şeması
-- Supabase SQL Editor'a kopyalayıp çalıştırın
-- ============================================================

-- Kategoriler
CREATE TABLE IF NOT EXISTS categories (
  id          UUID    DEFAULT gen_random_uuid() PRIMARY KEY,
  name_tr     TEXT    NOT NULL,
  name_en     TEXT    NOT NULL DEFAULT '',
  name_ru     TEXT    NOT NULL DEFAULT '',
  slug        TEXT    UNIQUE NOT NULL,
  sort_order  INTEGER DEFAULT 0,
  is_active   BOOLEAN DEFAULT true,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Ürünler
CREATE TABLE IF NOT EXISTS products (
  id              UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  category_id     UUID        REFERENCES categories(id) ON DELETE CASCADE,
  name_tr         TEXT        NOT NULL,
  name_en         TEXT        NOT NULL DEFAULT '',
  name_ru         TEXT        NOT NULL DEFAULT '',
  description_tr  TEXT        DEFAULT '',
  description_en  TEXT        DEFAULT '',
  description_ru  TEXT        DEFAULT '',
  price           NUMERIC(10,2) NOT NULL DEFAULT 0,
  currency        TEXT        DEFAULT 'TL',
  image_url       TEXT,
  is_active       BOOLEAN     DEFAULT true,
  is_featured     BOOLEAN     DEFAULT false,
  sort_order      INTEGER     DEFAULT 0,
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Ayarlar (tek satır)
CREATE TABLE IF NOT EXISTS settings (
  id                UUID  DEFAULT gen_random_uuid() PRIMARY KEY,
  restaurant_name   TEXT  DEFAULT 'Güneş Pansiyon',
  logo_url          TEXT,
  whatsapp_number   TEXT,
  address           TEXT,
  instagram_url     TEXT,
  default_language  TEXT  DEFAULT 'tr',
  currency          TEXT  DEFAULT 'TL',
  updated_at        TIMESTAMPTZ DEFAULT NOW()
);

-- updated_at otomatik güncelleme
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$;

DROP TRIGGER IF EXISTS trg_products_updated_at ON products;
CREATE TRIGGER trg_products_updated_at
  BEFORE UPDATE ON products
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================
-- Row Level Security
-- ============================================================
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE products    ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings    ENABLE ROW LEVEL SECURITY;

-- Herkes okuyabilir (public menü)
CREATE POLICY "public_read_categories" ON categories FOR SELECT USING (true);
CREATE POLICY "public_read_products"   ON products   FOR SELECT USING (true);
CREATE POLICY "public_read_settings"   ON settings   FOR SELECT USING (true);

-- Sadece giriş yapmış kullanıcılar (admin) yazabilir
CREATE POLICY "admin_all_categories" ON categories FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "admin_all_products"   ON products   FOR ALL USING (auth.role() = 'authenticated');
CREATE POLICY "admin_all_settings"   ON settings   FOR ALL USING (auth.role() = 'authenticated');

-- ============================================================
-- Başlangıç ayar kaydı
-- ============================================================
INSERT INTO settings (restaurant_name, default_language, currency)
VALUES ('Güneş Pansiyon', 'tr', 'TL')
ON CONFLICT DO NOTHING;

-- ============================================================
-- Storage Bucket Notu:
-- Supabase Dashboard > Storage > New Bucket
--   Bucket adı : menu-images
--   Public     : true (işaretleyin)
-- ============================================================

-- ============================================================
-- Admin Kullanıcı Notu:
-- Supabase Dashboard > Authentication > Users > Add User
--   E-posta ve şifre belirleyin.
--   Bu bilgilerle /admin sayfasından giriş yapın.
-- ============================================================
