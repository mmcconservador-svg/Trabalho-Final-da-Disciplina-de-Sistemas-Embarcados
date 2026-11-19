// Abre o app Flutter Web num Chrome (Playwright), navega pelas telas e salva capturas.
// Uso: node tool/capturar.js http://localhost:8080 shots
const { chromium } = require('playwright');
const fs = require('fs');

const url = process.argv[2] || 'http://localhost:8080';
const out = process.argv[3] || 'shots';
fs.mkdirSync(out, { recursive: true });

const perfis = [
  { nome: 'web-desktop', viewport: { width: 1100, height: 760 } },
  { nome: 'web-celular', viewport: { width: 412, height: 915 } },
];

async function clicar(page, nome, fallback) {
  // Com a semântica do Flutter ligada, os botões aparecem como role=button.
  const alvo = page.getByRole('button', { name: nome });
  try {
    await alvo.first().click({ timeout: 8000 });
  } catch (e) {
    console.log(`  (fallback por coordenadas para "${nome}")`, fallback);
    await page.mouse.click(fallback.x, fallback.y);
  }
  await page.waitForTimeout(1800);
}

(async () => {
  const browser = await chromium.launch({
    args: ['--use-angle=swiftshader', '--enable-unsafe-swiftshader', '--ignore-gpu-blocklist'],
  });

  for (const p of perfis) {
    console.log('Perfil', p.nome);
    const ctx = await browser.newContext({ viewport: p.viewport, deviceScaleFactor: 1 });
    const page = await ctx.newPage();
    page.on('console', (m) => console.log('  [console]', m.text().slice(0, 200)));
    await page.goto(url, { waitUntil: 'load' });
    await page.waitForSelector('flt-glass-pane', { timeout: 90000 });
    await page.waitForTimeout(4000);

    // Liga a árvore de semântica (acessibilidade) para podermos achar os botões por nome.
    try {
      await page.locator('flt-semantics-placeholder').dispatchEvent('click');
    } catch (e) {
      console.log('  semantics placeholder não encontrado');
    }
    await page.waitForTimeout(2500);

    const w = p.viewport.width;
    const h = p.viewport.height;
    // Posições aproximadas (fallback): botão "Ver gráfico" / "Voltar" ficam na base da tela.
    const base = { x: Math.round(w / 3), y: h - 36 };

    await page.screenshot({ path: `${out}/${p.nome}-1-tela1-registro.png` });

    // Botão flutuante "+" (contador de sessões com setState) clicado 3 vezes.
    for (let i = 0; i < 3; i++) {
      await clicar(page, /Sessões|sessão de estudo/i, { x: w - 80, y: h - 120 });
    }
    await page.screenshot({ path: `${out}/${p.nome}-2-tela1-sessoes.png` });

    // Tela 1 -> Tela 2 (Navigator.push)
    await clicar(page, /Ver gráfico/i, base);
    await page.waitForTimeout(1500);
    await page.screenshot({ path: `${out}/${p.nome}-3-tela2-grafico.png` });

    // Tela 2 -> Tela 1 (Navigator.pop)
    await clicar(page, /Voltar/i, base);
    await page.screenshot({ path: `${out}/${p.nome}-4-volta-tela1.png` });

    await ctx.close();
  }
  await browser.close();
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
