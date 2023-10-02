load <- \(path, f_pattern = ".rdata", full_name = T){
  list.files(path, pattern = f_pattern, full.names = full_name) -> fnames
  for(file in fnames){
    print(file)
    load(file)
  }
}
