{CompositeDisposable} = require 'atom'

module.exports = PythonVersionIncrement =
  activate: (state) ->
    atom.workspace.observeTextEditors (editor) ->
        editor.buffer.onWillSave ->
            versionRe = /(__version__ = ["'][0-9\.]*?)([0-9]+)(["'])/

            editor.buffer.backwardsScan(
                versionRe,
                (match) ->
                    version = ""
                    for i in [1...match.match.length-2]
                        version += match.match[i]
                    patchVersion = match.match[match.match.length-2]
                    version += String(parseInt(patchVersion)+1)
                    version += match.match[match.match.length-1]
                    console.log "version", version

                    match.replace(version)
            )


  deactivate: ->
    @subscriptions.dispose()
