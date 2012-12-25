module ReproductionSimbolsHelper
  def get_array_simbols
    simbols = []
    simbols[0] = t('reproductions.no_simbol')
    cont = 1

    ReproductionSimbol.all.each do |r|
      simbols[cont] = r.simbol+" "+r.meaning
      cont += 1
    end
    return simbols
  end
end