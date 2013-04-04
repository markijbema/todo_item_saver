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
    context "the list to save it to exists" do
      it "creates the todo and adds it to a list" do
        list, todo = mock, mock

        saver = TodoSaver.new('WriTing', 'write blogpost')

        TodoItem.should_receive(:create).with('write blogpost')
                .and_return(todo)

        List.stub(:retrieve).with('writing').and_return(list)

        list.should_receive(:add).with(todo)

        saver.save()
      end
    end
    context "the list to save it to does not exist" do
      it "creates the todo and adds it to a list" do
        list, todo = mock, mock

        saver = TodoSaver.new('WriTing', 'write blogpost')

        TodoItem.should_receive(:create).with('write blogpost')
                .and_return(todo)

        List.stub(:retrieve).with('writing').and_return(nil)
        List.stub(:create).with('WriTing').and_return(list)

        list.should_receive(:add).with(todo)

        saver.save()
      end
    end
  end
end
