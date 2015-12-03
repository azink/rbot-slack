Sequel.migration do
  up do
    create_table(:last) do
      String :nick
      String :chan
      String :stmt, :size => 512
      Fixnum :at, :index => true
      primary_key [:nick, :chan]
    end

    create_table(:whatis) do
      String :thekey, :primary_key => true
      String :value, :null => false, :size => 512
      String :nick
    end

    create_table(:cron) do
      Fixnum :at, :null => false, :index => true
      String :nick, :null => false
      String :chan, :null => false
      String :message, :null => false, :size => 512
      primary_key [:at, :nick, :message]
    end

    create_table(:points) do
      String :thing, :primary_key => true
      Fixnum :points
    end
  end

  down do
    drop_table :last
    drop_table :whatis
    drop_table :cron
    drop_table :points
  end
end
