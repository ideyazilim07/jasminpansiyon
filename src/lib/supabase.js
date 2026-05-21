import { createClient } from '@supabase/supabase-js'

export const supabase = createClient(
  'https://kktaumfpjmednqvgotvi.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtrdGF1bWZwam1lZG5xdmdvdHZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzkzNjQ0NjQsImV4cCI6MjA5NDk0MDQ2NH0.7PEfPbdOWKiyNldeuHIcGz-kmjh5mwQ9n0eExNRx5JA'
)
