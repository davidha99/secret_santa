class ExchangeEvent < ApplicationRecord
  has_many :exchanges, dependent: :destroy, inverse_of: :exchange_event
  after_save :run

  private

  def run
    @participants = Member.includes(:family, :exchanges)
    @graph = build_graph
    @path = ham_cycle
    create_exchanges
  end

  def create_exchanges
    @path.each do |s|
      r = @path[s + 1] || @path[0]
      Exchange.create(exchange_event: self, sender: @participants[s], recipient: @participants[r])
    end
  end

  def build_graph
    graph = Array.new(@participants.length) { Array.new(@participants.length, true) }
    # Constraints:
    graph.each_with_index do |row, i|
      row.each_with_index do |_, j|
        # 1. Members cannot be their own Secret Santa
        if i == j
          graph[i][j] = false
          next
        end

        # 2. A family member can only be paired with the same Secret Santa once every three years.
        exchanges = @participants[i].exchanges.pluck(:recipient_id, :created_at)
        exchanges.each do |recipient_id, created_at|
          if recipient_id == @participants[j].id && Time.zone.now.year - created_at.year < 3
            graph[i][j] = false
            break
          end
        end

        # 3. Immediate Family Members cannot select other members of their immediate family.
        graph[i][j] = false if @participants[i].family == @participants[j].family
      end
    end
    graph
  end

  def ham_cycle
    path = Array.new(@participants.length, -1)
    path[0] = 0 # Start from member at position participants[0]

    unless dfs(path, 1)
      puts 'Solution does not exist'
      return false
    end

    path
  end

  def dfs(path, pos)
    if pos == @participants.length
      return true if @graph[path[pos - 1]][path[0]]

      return false

    end

    (1...@participants.length).each do |v|
      next unless can_exchange?(v, pos, path)

      path[pos] = v

      return true if dfs(path, pos + 1)

      path[pos] = -1
    end

    false
  end

  def can_exchange?(v, pos, path)
    return false unless @graph[path[pos - 1]][v]

    return false if path.include?(v)

    true
  end
end
