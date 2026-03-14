import { Title } from "@solidjs/meta";
import { createResource, createSignal, Match, Show, Switch } from "solid-js";
import RegisterState from "./states/02-setup-webauthn";
import StartState from "./states/01-login-register";
import style from './login.module.css';

export type State = 'START' | 'REGISTER' | 'COMPLETE';

async function initializeSession() {
    const params = new URLSearchParams(window.location.search);
    const res = await fetch(`/authorize?${params}`, {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
    });
    if (!res.ok) throw new Error(`Authorization failed: ${res.status}`);
}

export default function LoginPage() {
    const [state, setState] = createSignal<State>('START');
    const [session] = createResource(initializeSession);

    return (
        <>
        <>
            <Title>Sign in to Blank</Title>
        </>
        <div class={style.wrapper}>
            <div class={style.plain}>
                <Show when={!session.error} fallback={<p>Authorization failed.</p>}>
                    <Switch>
                        <Match when={state() === 'START'}><StartState setState={setState}/></Match>
                        <Match when={state() === 'REGISTER'}><RegisterState/></Match>
                    </Switch>
                </Show>
                <footer class={`${style.footer} muted`}>
                    Copyright &copy; 2025
                </footer>
            </div>
            <div class={style.background}>
                <div class={style.slogan}>
                    State-of-the-art passwordless <br/>
                    authentication and authorization
                </div>
            </div>
        </div>
        </>
    )
}