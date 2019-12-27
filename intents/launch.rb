WELCOME_MESSAGE = 'Willkommen zu Naturiv, ' \
      'deinem freundlichen Naturstein Inventur Helferlein. Du kannst jetzt loslegen'.freeze

intent "LaunchRequest" do
  ask(WELCOME_MESSAGE)
end
