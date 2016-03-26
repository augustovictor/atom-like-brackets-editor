AtomLikeBracketsEditor = require '../lib/atom-like-brackets-editor'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "AtomLikeBracketsEditor", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('atom-like-brackets-editor')

  describe "when the atom-like-brackets-editor:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.atom-like-brackets-editor')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'atom-like-brackets-editor:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.atom-like-brackets-editor')).toExist()

        atomLikeBracketsEditorElement = workspaceElement.querySelector('.atom-like-brackets-editor')
        expect(atomLikeBracketsEditorElement).toExist()

        atomLikeBracketsEditorPanel = atom.workspace.panelForItem(atomLikeBracketsEditorElement)
        expect(atomLikeBracketsEditorPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'atom-like-brackets-editor:toggle'
        expect(atomLikeBracketsEditorPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.atom-like-brackets-editor')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'atom-like-brackets-editor:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        atomLikeBracketsEditorElement = workspaceElement.querySelector('.atom-like-brackets-editor')
        expect(atomLikeBracketsEditorElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'atom-like-brackets-editor:toggle'
        expect(atomLikeBracketsEditorElement).not.toBeVisible()
