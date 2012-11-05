# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ReproductionSimbol.create(:simbol => '♀', :meaning => 'Paríu femia')
ReproductionSimbol.create(:simbol =>'♂', :meaning=> 'Pariu macho')
ReproductionSimbol.create(:simbol =>'●', :meaning=> 'Aborto')
ReproductionSimbol.create(:simbol =>'●', :meaning=> 'Parto distódico')
ReproductionSimbol.create(:simbol =>'o', :meaning=> 'parto previsto')
ReproductionSimbol.create(:simbol =>'▲', :meaning=> 'Inseminación')
ReproductionSimbol.create(:simbol =>'△', :meaning=> 'Celo')
ReproductionSimbol.create(:simbol =>'⊕', :meaning=> 'Cria morta')
ReproductionSimbol.create(:simbol =>'◇', :meaning=> 'Aviso de secado')
ReproductionSimbol.create(:simbol =>'∢', :meaning=> 'Ollo ó celo')
ReproductionSimbol.create(:simbol =>'(-)', :meaning=> 'Baldeira')
ReproductionSimbol.create(:simbol =>'(?)', :meaning=> 'Dubidosa')
ReproductionSimbol.create(:simbol =>'(+)', :meaning=> 'D. positivo')
ReproductionSimbol.create(:simbol =>'S', :meaning=> 'Sucia')
ReproductionSimbol.create(:simbol =>'L', :meaning=> 'Lavado')
ReproductionSimbol.create(:simbol =>'R', :meaning=> 'Ret. Secundinas')
