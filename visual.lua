export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const key = url.searchParams.get('key');
    const pid = url.searchParams.get('pid');
    const authHeader = request.headers.get("X-Context-Auth");

    // Configurações Supabase
    const SB_URL = "https://nhzxrlclaofbfoxtbrkp.supabase.co/rest/v1";
    const SB_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5oenhybGNsYW9mYmZveHRicmtwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY1NDQ2MDUsImV4cCI6MjA4MjEyMDYwNX0.d1wQf8gDthjNkmYhAIMFFN7qbcc7Zk4pPE4RUaGZpp4";

    // 1. Validar Segurança do Loader
    if (authHeader !== "MathsHub_Secure_9981") {
      return new Response("Seguranca Inválida (Header)", { status: 403 });
    }

    // 2. Buscar Key
    const resKey = await fetch(`${SB_URL}/keys?key_value=eq.${key}&select=*`, {
      headers: { "apikey": SB_KEY, "Authorization": `Bearer ${SB_KEY}` }
    });
    const keys = await resKey.json();

    if (!keys || keys.length === 0) {
      return new Response("Chave nao existe no banco", { status: 401 });
    }

    const userData = keys[0];

    // 3. Verificar Ban
    if (userData.is_banned) {
      return new Response("Sua chave está BANIDA", { status: 403 });
    }

    // 4. Verificar IP
    const currentIP = request.headers.get("CF-Connecting-IP");
    if (userData.ip_address && userData.ip_address !== currentIP) {
      return new Response("IP Bloqueado! Use o Painel para Resetar", { status: 403 });
    }

    // Se IP estiver livre, salva o atual
    if (!userData.ip_address) {
      await fetch(`${SB_URL}/keys?key_value=eq.${key}`, {
        method: 'PATCH',
        headers: { "apikey": SB_KEY, "Authorization": `Bearer ${SB_KEY}`, "Content-Type": "application/json" },
        body: JSON.stringify({ ip_address: currentIP })
      });
    }

    // 5. Buscar Script pelo Prefixo
    const resScript = await fetch(`${SB_URL}/script_config?prefixo=eq.${userData.script_name}&select=*`, {
      headers: { "apikey": SB_KEY, "Authorization": `Bearer ${SB_KEY}` }
    });
    const scripts = await resScript.json();

    if (!scripts || scripts.length === 0) {
      return new Response("Script nao configurado (Prefixo erro)", { status: 404 });
    }

    return new Response(scripts[0].source_code, { status: 200 });
  }
};
