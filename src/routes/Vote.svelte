<script>
    export let params;
    import { replace } from 'svelte-spa-router';
    if (window.localStorage.hasOwnProperty('poll' + params.id)) {
        replace('/result/' + params.id);
    }
    async function vote(id) {
        try {
            const url = '/api/poll/answer/' + id;
            const response = await fetch(url, {method: 'PATCH'});
            const isJson = response.headers.get('content-type')?.includes('application/json');
            const data = isJson ? await response.json() : null;
            if (response.ok) {
                window.localStorage.setItem('poll' + params.id, id);
                replace('/result/' + params.id);
            } else {
                const error = (data && data.message) || response.status;
                // throw new Error(error);
                return Promise.reject(error);
            }
        } catch (error) {
            alert(error);
        }
    }
    async function fetchData() {
        const url = '/api/poll/' + params.id;
        const response = await fetch(url);
        const isJson = response.headers.get('content-type')?.includes('application/json');
        const data = isJson ? await response.json() : null;
        if (response.ok) {
            return data;
        } else {
            const error = (data && data.message) || response.status;
            // throw new Error(error);
            return Promise.reject(error);
        }
    }
</script>

<main>
    {#await fetchData()}
        <h1>Loading...</h1>
    {:then poll}
        <h1>{poll.question}</h1>
        <div class="label">Click answer to vote</div>
        {#each poll.answers as anwr}
            <button on:click={() => vote(anwr.id)}>{anwr.answer}</button>
        {/each}
    {:catch error}
        <h1>{error}</h1>
    {/await}
</main>
