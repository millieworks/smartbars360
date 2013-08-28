class Smartbar < ActiveRecord::Base
  attr_accessible :callback_url, :css, :minified_css, :customer_id, :html, :minified_html, :name, :position_element, :position_prepend, :status, :url, :url_regex, :rule_grouping, :rules_attributes

  belongs_to :customer
  has_many :rules, dependent: :destroy

  has_many :tracked_user_actions

  accepts_nested_attributes_for :rules, allow_destroy: true

  validates_presence_of :name, :customer_id, :url
  validates_presence_of :html, if: :active_or_markup?

  validates_uniqueness_of :name, scope: :customer_id

  before_save :minify_html, :minify_css, :regexify_url

  def active?
    status == "active"
  end

  def active_or_markup?
    status.include?("markup") || active?
  end

  def issue_callback(tracked_user_public_id, data)
    return if self.callback_url.blank?

    uri = URI(callback_url_with_query_string(tracked_user_public_id, data))
    require (uri.scheme == "https") ? 'net/https' : 'net/http'
    response = Net::HTTP.get_response(uri)
    (response.code.to_i >= 200 && response.code.to_i <= 299) ?
        logger.debug("Response from callback (#{self.callback_url}) = #{response.code}") :
        logger.warn("Response from callback (#{self.callback_url}) = #{response.code}")
  end

  def callback_url_with_query_string(tracked_user_public_id, data = {})
    query = "?user_id=#{tracked_user_public_id}&smartbar=#{self.name.parameterize}"
    data.each do |key, value|
      query << "&#{key}=#{value}"
    end unless data.empty?
    self.callback_url + query
  end

  def url_matches?(url)
    !Regexp.new(url_regex).match(url).nil?
  end

  def has_no_rules
    self.rules.count == 0
  end

  private
    def minify_html
      return if html.blank?
      self.minified_html = HTMLMin.minify(html.gsub("'", "&apos;"), {
          indent_doctype: false,
          remove_comments: true,
          remove_conditional_comments: true,
          minify_whitespaces: true,
          max_line_len: 32768,
          minify_entities: false,
          entities_to_chars: false
      })
    end

    def minify_css
      return if css.blank?
      self.minified_css = css.gsub(/\r\n|\n/, ' ').gsub('"', "'").gsub(/\s\s+/, "\s")
    end

    def regexify_url
      return if url.blank?
      urls = url.split(",")
      urls.map! { |u| u.strip }
      urls.map! { |u| "^" + Regexp.escape(u).gsub("\\*", ".*").gsub("\\?", ".") + "/?$" }
      self.url_regex = urls.join("|")
    end
end
