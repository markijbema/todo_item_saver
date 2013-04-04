### Not shown in blog post
require 'rspec/autorun'

class TodoItem
end

####


class TodoSaver
  def initialize list_name, todo_text
    @list_name = list_name
    @todo_text = todo_text
  end

  def save
    todo = TodoItem.create(@todo_text)
    list.add todo
  end
end

describe TodoSaver do
  describe '#save' do
    it "creates the todo and adds it to a list" do
      list, todo = mock, mock

      saver = TodoSaver.new('Writing', 'write blogpost')

      TodoItem.should_receive(:create).with('write blogpost')
              .and_return(todo)

      saver.stub list: list
      list.should_receive(:add).with(todo)

      saver.save()
    end
  end
  describe '.list' do
  end
end
