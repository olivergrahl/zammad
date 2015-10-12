class App.TicketArticle extends App.Model
  @configure 'TicketArticle', 'from', 'to', 'cc', 'subject', 'body', 'content_type', 'ticket_id', 'type_id', 'sender_id', 'internal', 'in_reply_to', 'form_id', 'preferences', 'updated_at'
  @extend Spine.Model.Ajax
  @url: @apiPath + '/ticket_articles'
  @configure_attributes = [
      { name: 'ticket_id',      display: 'TicketID',    null: false, readonly: 1, },
      { name: 'from',           display: 'From',        tag: 'input',    type: 'text', limit: 100, null: false },
      { name: 'to',             display: 'To',          tag: 'input',    type: 'text', limit: 100, null: true },
      { name: 'cc',             display: 'Cc',          tag: 'input',    type: 'text', limit: 100, null: true },
      { name: 'subject',        display: 'Subject',     tag: 'input',    type: 'text', limit: 100, null: true },
      { name: 'body',           display: 'Text',        tag: 'textarea', rows: 5,      limit: 100, null: false },
      { name: 'type_id',        display: 'Type',        tag: 'select',   multiple: false, null: false, relation: 'TicketArticleType', default: '' },
      { name: 'sender_id',      display: 'Sender',      tag: 'select',   multiple: false, null: false, relation: 'TicketArticleSender', default: '' },
      { name: 'internal',       display: 'Visibility',  tag: 'radio',  default: false,  null: true, options: { true: 'internal', false: 'public' } },
      { name: 'created_by_id',  display: 'Created by',  relation: 'User', readonly: 1 },
      { name: 'created_at',     display: 'Created',     tag: 'datetime', readonly: 1 },
      { name: 'updated_by_id',  display: 'Updated by',  relation: 'User', readonly: 1 },
      { name: 'updated_at',     display: 'Updated',     tag: 'datetime', readonly: 1 },
    ]

  uiUrl: ->
    '#ticket/zoom/' + @ticket_id + '/' + @id

  objectDisplayName: ->
    'Article'

  displayName: ->
    if @subject
      return @subject
    if App.Ticket.exists( @ticket_id )
      ticket = App.Ticket.find( @ticket_id )
    if ticket
      return ticket.title
    '???'

  iconActivity: (user) ->
    ticket = App.Ticket.find(@ticket_id)
    if ticket.owner_id == user.id
      return 'important'
    ''