# encoding: utf-8
namespace :app do
  desc "Encripta todas as senhas \
que ainda não foram processadas \
no banco de dados"

  task(migrar_senhas: :environment) do

    unless User.attribute_names.include? "Password"
      puts "As senhas já foram migradas, terminado"
      return
    end

    User.find_each do |user|
      puts "Migrando Usuario ##{user.id} #{user.full_name}"
      if !user.valid? || user.attributes["password"].blank?
        puts "Usuário id #{user.id} inválido, pulando."
        puts "Corrija-o manualmente e tente novamente.\n\n"
        next
      end

      unecripetd_password = user.attributes["password"]

      user.password = unecripetd_password
      user.password_confirmation = unecripetd_password
      user.save!
    end

  end
end