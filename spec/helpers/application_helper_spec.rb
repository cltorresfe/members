require 'rails_helper'

RSpec.describe ApplicationHelper do

  describe '#get_title' do
    subject{ helper.get_title }

    context 'title is in context' do
      before do
        helper.content_for(:title, 'Index')
      end

      it { is_expected.to eq('Index - Plataforma Miembros de Iglesia')}
    end

    context 'title is not in context but has found a title by locale' do
      before do
        controller.stub(:controller_name).and_return('members')
        controller.stub(:action_name).and_return('index')
      end

      it { is_expected.to eq('Listado de Miembros - Plataforma Miembros de Iglesia')}
    end

    context 'title is not in context or locale' do
      it { is_expected.to eq('Plataforma Miembros de Iglesia')}
    end

  end

  describe '#i18n_title' do
    subject{ helper.i18n_title }

    context 'title is found in locale' do
      before do
        controller.stub(:controller_name).and_return('members')
        controller.stub(:action_name).and_return('index')
      end

      it { is_expected.to eq("Listado de Miembros")}
    end

    context 'title is not found' do
      it { is_expected.to eq('')}
    end

  end

  describe '#prioritary_countries' do
    subject{ helper.prioritary_countries }

    it { is_expected.to eq(['CL'])}
  end
end