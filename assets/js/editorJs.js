import EditorJS from '@editorjs/editorjs';

export default {
  mounted() {
    this.initEditor();
    console.log('editor is mounted')
    this.editorSaveAction()
    this.editorShowAction()
  },
  beforeUpdate() {
    this.initEditor(); 
    console.log('editor before mounted')
  },
  updated() {
    console.log('editor updated')

  },
  destroyed() {
    console.log('editor distroyed')
    if (this.editor) {
      this.editor.destroy();
      this.editor = null;
    }
  },
  initEditor() {
    if (!document.getElementById('editorjs')) {
      return; // Avoid initializing if the container isn't present
    }

    this.editor = new EditorJS({
      holder: 'editorjs',
      // readOnly: true,
      autofocus: true,
      onReady: () => {
        console.log('Editor.js is ready to work!');
      }
    });
  },
  editorShowAction() {
    const hook = this;


    hook.handleEvent("content-saved", ({content}) => {
      this.editor.render(content);
      console.log(content)
    });

  },
  editorSaveAction() {
    const hook = this;
    const saveButton = document.getElementById('save-button');

    saveButton.addEventListener('click', () => {
      this.editor.save().then(savedData => {
        hook.pushEvent('save-editor-content', { content: savedData });
        this.editor.clear()
      }).catch((error) => {
        console.error('Saving failed:', error);
      });
    });
  }
};
