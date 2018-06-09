require_relative '../../test_helper'

SingleCov.covered!

describe Pagy::Backend do


  describe "#pagy_get_vars" do
    before do
      @collection = TestCollection.new((1..1000).to_a)
    end

    def test_items_default
      vars   = {}
      backend = TestController.new
      merged = backend.send :pagy_get_vars, @collection, vars
      assert_includes(merged.keys, :items)
      assert_nil(merged[:items])
    end

    def test_items_vars
      vars   = {items: 15}     # force items
      params = {:a=>"a", :page=>3, :items=>12}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(15, pagy.items)
    end

    def test_items_params
      vars   = {}
      params = {:a=>"a", :page=>3, :items=>12}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(12, pagy.items)
    end

    def test_items_params_override
      vars   = {items: 21}
      params = {:a=>"a", :page=>3, :items=>12}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(21, pagy.items)
    end


    def test_items_bigger_than_max
      vars   = {}
      params = {:a=>"a", :page=>3, :items=>120}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(100, pagy.items)
    end


    def test_items_unlimited
      vars   = {max_items: nil}
      params = {:a=>"a", :items=>1000}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(1000, pagy.items)
    end

    def test_items_unlimited_vars
      fork{
      vars = {}
      Pagy::VARS[:max_items] = nil
      params = {:a=>"a", :items=>1000}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(1000, pagy.items)
      }
    end

    def test_items_param
      vars   = {items_param: :custom}
      params = {:a=>"a", :page=>3, :items_param=>:custom, :custom=>14}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(14, pagy.items)
    end

    def test_items_param_global
      fork{
      vars = {}
      Pagy::VARS[:items_param] = :custom
      params = {:a=>"a", :page=>3, :custom=>15}

      backend = TestController.new params
      assert_equal(params, backend.params)

      pagy, _ = backend.send :pagy, @collection, vars
      assert_equal(15, pagy.items)
      }
    end

  end
end
