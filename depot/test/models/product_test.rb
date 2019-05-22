require 'test_helper'
class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
# assert true
# end
def new_product(image_url)
  Product.new(title: "My Book Title",
              description: "yyy",
              price: 1,
              image_url: image_url)

end

test "image url" do
  ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
  bad = %w{ fred.doc fred.gif/more fred.gif.more }
  ok.each do |name|
    assert new_product(name).valid?, "#{name} shouldn't be invalid"
  end
  bad.each do |name|
    assert new_product(name).invalid?, "#{name} shouldn't be valid"
  end
end

  test " product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:cup).title,
                          description: "
                             Our cup made with durable material.
                             You can create personal print or buy the one that is available.",
                          image_url: "cup.jpg",
                          price: 150.00)
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end
end