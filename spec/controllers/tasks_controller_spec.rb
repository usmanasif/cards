require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  before { sign_in user }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new task" do
        expect {
          post :create, params: { task: attributes_for(:task) }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the root path" do
        post :create, params: { task: attributes_for(:task) }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a new task" do
        expect {
          post :create, params: { task: attributes_for(:task, name: nil) }
        }.not_to change(Task, :count)
      end
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: task.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the task" do
        patch :update, params: { id: task.id, task: { name: "New Name" } }
        expect(task.reload.name).to eq("New Name")
      end

      it "redirects to the root path" do
        patch :update, params: { id: task.id, task: { name: "New Name" } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the task" do
        patch :update, params: { id: task.id, task: { name: nil } }
        expect(task.reload.name).not_to be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the task" do
      task_to_delete = create(:task)
      expect {
        delete :destroy, params: { id: task_to_delete.id }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the root path" do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PATCH #update_task_status" do
    it "updates the task status" do
      patch :update_task_status, params: { id: task.id, is_completed: true }
      expect(task.reload.is_completed).to eq(false)
    end

    it "redirects to the root path" do
      patch :update_task_status, params: { id: task.id, is_completed: true }
      expect(response).to redirect_to(root_path)
    end
  end
end
