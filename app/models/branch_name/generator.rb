class BranchName::Generator
  private attr_reader :task_name, :task_number

  def initialize(task_name:, task_number:)
    @task_name = task_name
    @task_number = task_number
  end

  def generate
    return nil if task_name.blank? || task_number.blank?

    slug = task_name.downcase
    slug = slug.gsub(/[\s_]+/, '-')
    slug = slug.gsub(/[^a-z0-9\-]/, '')
    slug = slug.gsub(/-+/, '-')
    slug = slug.gsub(/^-+|-+$/, '')

    "#{task_number}-#{slug}"
  end
end

