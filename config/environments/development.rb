require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Les paramètres spécifiés ici auront priorité sur ceux de config/application.rb.

  # Environnement de développement : le code est rechargé à chaque modification.
  # Cela ralentit le temps de réponse mais est parfait pour le développement
  # car vous n'avez pas besoin de redémarrer le serveur web pour voir les changements.
  config.cache_classes = false

  # Ne chargez pas le code au démarrage.
  config.eager_load = false

  # Affichez les rapports d'erreurs complets.
  config.consider_all_requests_local = true

  # Configuration de l'URL par défaut pour l'Action Mailer.
  config.action_mailer.delivery_method = :letter_opener_web


  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.mic.com',
    port:                 587,
    domain:               'mic.com',
    user_name:            'admin@mic.com',
    password:             'Password',
    authentication:       'plain',
    enable_starttls_auto: true
  }

  # Activer/désactiver la mise en cache. Par défaut, la mise en cache est désactivée.
  # Exécutez "rails dev:cache" pour basculer la mise en cache.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Stockage des fichiers téléchargés sur le système de fichiers local (voir config/storage.yml pour les options).
  config.active_storage.service = :local

  # Ne pas se soucier si le mailer ne peut pas envoyer.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false

  # Affichez les avis de dépréciation dans le journal Rails.
  config.active_support.deprecation = :log

  # Lève des exceptions pour les dépréciations non autorisées.
  config.active_support.disallowed_deprecation = :raise

  # Indiquez à Active Support les messages de dépréciation à interdire.
  config.active_support.disallowed_deprecation_warnings = []

  # Lever une erreur lors du chargement de la page s'il y a des migrations en attente.
  config.active_record.migration_error = :page_load

  # Mettez en surbrillance le code qui a déclenché des requêtes de base de données dans les journaux.
  config.active_record.verbose_query_logs = true

  # Le mode debug désactive la concaténation et le prétraitement des assets.
  # Cette option peut entraîner des délais importants dans le rendu des vues avec un grand
  # nombre d'assets complexes.
  config.assets.debug = true
  config.assets.digest = true


  # Supprimer la sortie du logger pour les requêtes d'assets.
  config.assets.quiet = true

  # Lever une erreur pour les traductions manquantes.
  # config.i18n.raise_on_missing_translations = true

  # Annoter les vues rendues avec les noms de fichiers.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Utiliser un observateur de fichiers événementiel pour détecter de manière asynchrone les modifications dans le code source,
  # les routes, les locales, etc. Cette fonctionnalité dépend de la gem "listen".
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Décommentez si vous souhaitez autoriser l'accès à Action Cable depuis n'importe quelle origine.
  # config.action_cable.disable_request_forgery_protection = true
end
