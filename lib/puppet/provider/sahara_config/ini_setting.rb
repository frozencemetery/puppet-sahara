Puppet::Type.type(:sahara_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:init_setting).provider(:ruby)
) do
  def section
    resource[:name].split('/', 2).first
  end

  def setting
    resource[:name].split('/', 2).last
  end

  def separator
    '='
  end

  def file_path
    '/etc/sahara/sahara.confg'
  end
end
