require 'spec_helper'

describe Alephant::Publisher::Request::DataMapperFactory do
  let (:api_host) { 'https://www.test-api.com' }
  let (:connection) { instance_double(Faraday::Connection) }
  let (:base_path) { File.join(File.dirname(__FILE__), 'fixtures') }

  subject { described_class.new(api_host, connection, base_path) }

  describe ".create" do
    let (:context) do
      {
        :foo => :bar
      }
    end

    context "using valid parameters" do
      let (:component_id) { 'foo' }
      let (:expected) { FooMapper }

      specify { expect(subject.create(component_id, context)).to be_a expected }
    end

    context "using invalid path" do
      let (:base_path) { File.join(File.dirname(__FILE__), 'non_existent_path') }
      let (:expected_exception) { Alephant::Publisher::Request::InvalidComponentBasePath }

      specify { expect{ subject.create(component_id, context) }.to raise_error expected_exception }
    end

    context "using invalid component name" do
      let (:component_id) { 'bar' }
      let (:expected_exception) { Alephant::Publisher::Request::InvalidComponentName }

      specify { expect{ subject.create(component_id, context) }.to raise_error expected_exception }
    end
  end
end
