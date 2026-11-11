# Gera glossário e lista de siglas (pacote glossaries) a cada compilação
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
sub run_makeglossaries {
  my ($base_name, $path) = fileparse($_[0]);
  my @args = ("-q", "$base_name");
  if ($path) { unshift @args, ("-d", "$path"); }
  return system('makeglossaries', @args);
}
push @generated_exts, 'glo', 'gls', 'glg', 'acn', 'acr', 'alg', 'ist';
$pdf_mode = 1;
