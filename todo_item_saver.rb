### Not shown in blog post
require 'rspec/autorun'

class TodoItem
end

class List
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

  def list
    List.retrieve(@list_name.downcase) ||
      List.create(@list_name)
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
    it 'retrieves an existing list by its normalized name' do
      list = mock
      saver = TodoSaver.new('WriTing', mock)
      List.stub(:retrieve).with('writing').and_return(list)

      expect(saver.list).to eq list
    end

    it 'creates a new list if no previous list was found' do
      list = mock
      saver = TodoSaver.new('WriTing', mock)
      List.stub(:retrieve).with('writing').and_return(nil)
      List.stub(:create).with('WriTing').and_return(list)

      expect(saver.list).to eq list
    end
  end
end
