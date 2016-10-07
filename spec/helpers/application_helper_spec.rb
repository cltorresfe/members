require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#full_title' do
    subject { helper.full_title }

    context 'title is in context' do
      before do
        helper.content_for(:title, 'Index')
      end

      it { is_expected.to eq('Index - eDiscípulo') }
    end

    context 'title is not in context but has found a title by locale' do
      before do
        allow(controller).to receive(:controller_name).and_return('members')
        allow(controller).to receive(:action_name).and_return('index')
      end

      it { is_expected.to eq('Listado de Miembros - eDiscípulo') }
    end

    context 'title is not in context or locale' do
      it { is_expected.to eq('eDiscípulo') }
    end
  end

  describe '#i18n_title' do
    subject { helper.i18n_title }

    context 'title is found in locale' do
      before do
        allow(controller).to receive(:controller_name).and_return('members')
        allow(controller).to receive(:action_name).and_return('index')
      end

      it { is_expected.to eq('Listado de Miembros') }
    end

    context 'title is not found' do
      it { is_expected.to eq('') }
    end
  end

  describe '#prioritary_countries' do
    subject { helper.prioritary_countries }

    it { is_expected.to eq(['CL']) }
  end

  describe '#avatar_for' do
    let!(:member) { create(:member, gender: false) }
    subject { helper.avatar_for(member) }

    it { is_expected.to include('img-circle') }
  end

  describe '#image_for' do
    let!(:member) { create(:member, gender: false) }
    subject { helper.image_for(member) }

    it { is_expected.to include('img-responsive') }
  end

  describe '#bootstrap_class_for' do
    subject { helper.bootstrap_class_for 'notice' }

    it { is_expected.to eq('alert-info') }
  end
end
