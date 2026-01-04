class BranchName::Generator
  private attr_reader :task_name, :task_number, :platform

  def initialize(task_name:, task_number:, platform: :dashboard)
    @task_name = task_name
    @task_number = task_number
    @platform = platform.to_sym
  end

  def generate
    return nil if task_name.blank? || task_number.blank?

    slug = task_name.downcase
    slug = slug.gsub(/[\s_]+/, '-')
    slug = slug.gsub(/[^a-z0-9\-]/, '')
    slug = slug.gsub(/-+/, '-')
    slug = slug.gsub(/^-+|-+$/, '')

    prefix = platform == :mobile ? "mob-" : ""
    "#{task_number}-#{prefix}#{slug}"
  end
end

