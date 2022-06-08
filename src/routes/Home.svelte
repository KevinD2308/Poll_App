<script>
    import { onMount, tick } from 'svelte';
    import autosize from 'svelte-autosize';
    let poll = {
        question: '',
        answers: ['', '', '']
    }
    onMount(() => document.querySelector('textarea:first-of-type').focus());
    async function addAnswer(e) {
        e.preventDefault();
        poll.answers = [...poll.answers, '']; 
        await tick();
        document.querySelector('textarea:last-of-type').focus();
    }
    async function removeAnswer(e) {
        e.preventDefault();
        poll.answers = [...poll.answers.slice(0, poll.answers.length - 1)];
        await tick();
        document.querySelector('textarea:last-of-type').focus();
    }
    function keyControl(e) {
        const firstEl = document.querySelector('textarea:first-of-type');
        const lastEl = document.querySelector('textarea:last-of-type');
        const focusedEl = document.activeElement;
        if (e.key === 'Enter') {
            e.preventDefault();
            if (lastEl !== focusedEl) {
                if (focusedEl === firstEl) {
                    // needs to jump over label
                    focusedEl.nextElementSibling.nextElementSibling.focus();
                } else {
                    focusedEl.nextElementSibling.focus();
                }
            }
        }
        if (lastEl === focusedEl) {
            if (e.key === 'Enter') {
                addAnswer(e);
            } else if (e.key === 'Backspace') {
                if(focusedEl.value === '') {
                    removeAnswer(e);
                }
            }
        }
    }
</script>

<main>

    <form>
        <div class="label">Question</div>
        <textarea rows="3"
            bind:value={poll.question} 
            required
            on:keydown={keyControl}
            use:autosize
        ></textarea>
        <div class="label">Answers</div>
        {#each poll.answers as anwr}
            <textarea rows="3"
                bind:value={anwr} 
                required
                on:keydown={keyControl}
                use:autosize
            ></textarea>
        {/each}
        <div id="buttons">
            <button on:click={addAnswer}>Add</button>
            <button on:click={removeAnswer}>Remove</button>
        </div>
    </form>    

</main>

<style>
    textarea {
        display: block;
        resize: none;
        width: 100%;
        margin: 0 0 1rem 0;
        padding: 1rem;
        border: 1px solid #d0d7de;
        border-radius: 4px;
        font-family: inherit;
        font-size: 1.2rem;
        color: inherit;
    }
    textarea:focus {
        outline: none;
        border-color: #b6b7b8;
    }
    #buttons {
        display: flex;
        justify-content: flex-end;
    }
    button {
        display: block;
        margin: 0 0 0 10px;
        padding: 9px 22px;
        border: 1px solid #d0d7de;
        border-radius: 4px;
        background-color: #f6f8fa;
        font-weight: 500;
        cursor: pointer;
        font-size: inherit;
    }
    button:hover {
        border-color: #b6b7b8;
        background-color: #eaecee;
    }
    button:last-child {
        color: #fff;
        background-color: #2ca44e;
        border-color: #23853f;
    }
    button:last-child:hover {
        background-color: #248640;
        border-color: #1b6630;
    }
    @media (max-width: 500px) {
        #buttons {
            flex-wrap: wrap;
        }
        button {
		    flex-basis: 0;
            flex-shrink: 0;
            flex-grow: 1;
            margin-left: 5px;
        }
        button:first-child {
            margin-left: 0;
            margin-right: 5px;
        }
        button:last-child {
            flex-basis: 100%;
            flex-shrink: 1;
            flex-grow: 0;
            margin: 10px 0 0 0;
        }
    }
</style>
