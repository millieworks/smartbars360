class SmartbarDecorator < Draper::Base
  decorates :smartbar
  decorates_association :rules

  def html
    CodeRay.scan(smartbar.html, :html).div.html_safe
  end

  def css
    CodeRay.scan(smartbar.css, :css).div.html_safe unless smartbar.css.strip.blank?
  end
end