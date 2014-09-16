StatusBarView = require './status-bar-view'
FileInfoView = require './file-info-view'
CursorPositionView = require './cursor-position-view'
SelectionCountView = require './selection-count-view'
GitView = require './git-view'

module.exports =
  activate: (state = {}) ->
    state.attached ?= true
    @statusBar = new StatusBarView(state)
    atom.workspaceView.statusBar = @statusBar

    atom.workspaceView.command 'status-bar:toggle', => @statusBar.toggle()

    if atom.getLoadSettings().devMode
      DevModeView = require './dev-mode-view'
      devModeView = new DevModeView()
      devModeView.initialize()
      @statusBar.appendLeft(devModeView)

    @fileInfo = new FileInfoView()
    @fileInfo.initialize()
    @statusBar.appendLeft(@fileInfo)

    @cursorPosition = new CursorPositionView()
    @cursorPosition.initialize()
    @statusBar.appendLeft(@cursorPosition)

    @selectionCount = new SelectionCountView()
    @selectionCount.initialize()
    @statusBar.appendLeft(@selectionCount)

    @git = new GitView()
    @git.initialize()
    @statusBar.appendRight(@git)

  deactivate: ->
    @git?.destroy()
    @git = null

    @fileInfo?.destroy()
    @fileInfo = null

    @cursorPosition?.destroy()
    @cursorPosition = null

    @selectionCount?.destroy()
    @selectionCount = null

    @statusBar?.destroy()
    @statusBar = null

    atom.workspaceView.statusBar = null
