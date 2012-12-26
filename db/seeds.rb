# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user = User.create email: "user@xegra.es", password: "adminadmin", name: "paula", password_confirmation: "adminadmin", surname1: "g", surname2: "c", cea: "333"
@cow = @user.cow.create ring: "99999999999999", name: "eneka", date_born: "2012-12-12", is_milk: true, num_borns: 1, is_active: 1
Rails.logger.debug @cow.errors.inspect

#
#ReproductionSimbol.create(:simbol => '♀', :meaning => 'Paríu femia')
#ReproductionSimbol.create(:simbol =>'♂', :meaning=> 'Pariu macho')
#ReproductionSimbol.create(:simbol =>'●', :meaning=> 'Aborto')
#ReproductionSimbol.create(:simbol =>'●', :meaning=> 'Parto distódico')
#ReproductionSimbol.create(:simbol =>'o', :meaning=> 'parto previsto')
#ReproductionSimbol.create(:simbol =>'▲', :meaning=> 'Inseminación')
#ReproductionSimbol.create(:simbol =>'△', :meaning=> 'Celo')
#ReproductionSimbol.create(:simbol =>'⊕', :meaning=> 'Cria morta')
#ReproductionSimbol.create(:simbol =>'◇', :meaning=> 'Aviso de secado')
#ReproductionSimbol.create(:simbol =>'∢', :meaning=> 'Ollo ó celo')
#ReproductionSimbol.create(:simbol =>'(-)', :meaning=> 'Baldeira')
#ReproductionSimbol.create(:simbol =>'(?)', :meaning=> 'Dubidosa')
#ReproductionSimbol.create(:simbol =>'(+)', :meaning=> 'D. positivo')
#ReproductionSimbol.create(:simbol =>'S', :meaning=> 'Sucia')
#ReproductionSimbol.create(:simbol =>'L', :meaning=> 'Lavado')
#ReproductionSimbol.create(:simbol =>'R', :meaning=> 'Ret. Secundinas')
