package dev.padak.backend.QualityTest;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/urun")
public class UrunController {

    @PreAuthorize("hasAuthority('YONETICI')")
    @PostMapping("/ekle")
    public ResponseEntity<String> urunEkle(@RequestBody UrunDTO urun) {
        System.out.println("Ürün eklendi: " + urun);
        return ResponseEntity.ok("Ürün eklendi");
    }
}