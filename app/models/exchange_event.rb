class ExchangeEvent < ApplicationRecord
  has_many :exchanges, dependent: :destroy, inverse_of: :exchange_event
  after_save :run

  private

  def run
    graph = build_graph
    # TODO: Call the run_event method to find a valid solution
    # results = run_event(graph)
  end

  def build_graph
    # TODO: In case of implemeting user auth, this would change to:
    # participants = Member.where(user: user).includes(:family, :given_gifts)
    participants = Member.includes(:family, :given_gifts)
    graph = Array.new(participants.length) { Array.new(participants.length, true) }
    # Constraints:
    graph.each_with_index do |row, i|
      row.each_with_index do |_, j|
        # 1. Members cannot be their own Secret Santa
        if i == j
          graph[i][j] = false
          next
        end

        # 2. A family member can only be paired with the same Secret Santa once every three years.
        exchanges = participants[i].given_gifts.pluck(:recipient_id, :created_at)
        exchanges.each do |recipient_id, created_at|
          if recipient_id == participants[j].id && created_at > 3.years.ago
            graph[i][j] = false
            break
          end
        end

        # 3. Immediate Family Members cannot select other members of their immediate family.
        graph[i][j] = false if participants[i].family == participants[j].family
      end
    end
    graph
  end

  # TODO: Implement Backtrcking (DFS) algorithm to find a valid solution
  def run_event
  end
end
