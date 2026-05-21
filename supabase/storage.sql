-- ============================================================
-- Supabase Storage — menu-images bucket politikaları
-- Supabase SQL Editor'da çalıştırın
-- ============================================================

-- Herkese okuma izni (public menüde görsel görünsün)
CREATE POLICY "public_read_menu_images" ON storage.objects
  FOR SELECT USING (bucket_id = 'menu-images');

-- Giriş yapmış admin yükleyebilir
CREATE POLICY "auth_insert_menu_images" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'menu-images' AND auth.role() = 'authenticated');

-- Giriş yapmış admin güncelleyebilir
CREATE POLICY "auth_update_menu_images" ON storage.objects
  FOR UPDATE USING (bucket_id = 'menu-images' AND auth.role() = 'authenticated');

-- Giriş yapmış admin silebilir
CREATE POLICY "auth_delete_menu_images" ON storage.objects
  FOR DELETE USING (bucket_id = 'menu-images' AND auth.role() = 'authenticated');
