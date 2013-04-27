class TaskPdf < Prawn::Document
  def initialize(tasks, order)
    super(top_margin: 70)
    @tasks = tasks
    @order = order
    report_header
    line_items
  end

  def report_header
    text "Club Manager - #{@order}", size: 30, style: :bold
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Name", "Department", "Due Date", "Status", "Assigned To", "Created By"]] +
    @tasks.map do |task|
      [task.name, task.department_name, task.due_at.strftime('%m/%d/%Y'), task.state, task.assignee_full_name, task.owner.full_name]
    end
  end
end
