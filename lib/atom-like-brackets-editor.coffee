AtomLikeBracketsEditorView = require './atom-like-brackets-editor-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomLikeBracketsEditor =
  atomLikeBracketsEditorView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomLikeBracketsEditorView = new AtomLikeBracketsEditorView(state.atomLikeBracketsEditorViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomLikeBracketsEditorView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-like-brackets-editor:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomLikeBracketsEditorView.destroy()

  serialize: ->
    atomLikeBracketsEditorViewState: @atomLikeBracketsEditorView.serialize()

  toggle: ->
    console.log 'AtomLikeBracketsEditor was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
