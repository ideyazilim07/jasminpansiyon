import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://kktaumfpjmednqvgotvi.supabase.co'
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtrdGF1bWZwam1lZG5xdmdvdHZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzkzNjQ0NjQsImV4cCI6MjA5NDk0MDY0NH0.7PEfPbdOWKiyNldeuHIcGz-kmjh5mwQ9n0eExNRx5JA'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
