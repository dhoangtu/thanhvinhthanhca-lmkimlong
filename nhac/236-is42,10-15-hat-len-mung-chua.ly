% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hát Lên Mừng Chúa" }
  composer = "Is. 42,10-15"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8. g16 e8 c |
  f4 \tuplet 3/2 { e8 e g } |
  a2 |
  bf8. bf16 c (d) c8 |
  g4 \tuplet 3/2 { a8 f d } |
  e4 r8 e |
  a a r fs |
  g8. a16 g8 e |
  d4 r8 d |
  d \slashedGrace { \parenthesize d16 ( } f8) r d |
  g8. g16 bf,8 d |
  c4 r8 \bar "||"
  
  <> \tweak extra-offset #'(-6 . -2.5) _\markup { \bold "ĐK:" }
  c |
  g' g r a |
  f8. f16 a8 f |
  e4 e8 e |
  f4. d8 |
  g g4 g8 |
  e4 r8 e |
  a a r c |
  bf8. bf16 a8 d |
  d4 g,8 g |
  e'4. e8 |
  d a4 bf8 |
  c2 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  R2*11
  r4.
  c8 |
  bf c r c |
  d8. d16 f8 d |
  c4 c8 c |
  d4. c8 |
  bf bf4 bf8 |
  c4 r8 c |
  f f r e |
  g8. g16 fs8 fs |
  g4 g8 g |
  c4. c8 |
  g8 f4 d8 |
  e2
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Hãy hát lên mừng Chưa một bài ca mới,
      Từ cùng cõi địa cầu tán dương Ngài đi.
      Gầm vang lên, đại dương với muôn hải vật,
      Ngàn quần \markup { \italic \underline "đảo" }
      cùng với hết thảy chúng dân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa giống trang kiệt sĩ vào trận hiêu dũng,
	    Bừng bừng khí anh hào lẫm liệt vùng lên.
	    Hô xung phong Ngài vung cánh tay uy hùng
	    Và gào thét mà trấn đánh mọi quân thù.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa phán: Ta từng đã ngồi lặng im mãi,
	    Dằn lòng nín thinh hoài, cứ giả làm ngơ,
	    Gào lên như phụ nữ lúc đang lầm bồn,
	    Hồng hộc \markup { \italic \underline "thở" }
	    mà hổn hển tựa đứt hơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa phá tan tành hết ngàn đồi, muôn núi,
	    Và làm cho thảo mộc bỗng lụi tàn đi.
	    Ngài sẽ biến dòng sông trở nên hoàng địa
	    và hồ vũng thành chỗ nắng hạn khô cằn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Hết những ai mù tối đều được Ta dẫn,
	    Vào đường chúng chưa tường hớn hở cùng đi.
	    Vì đây Ta đổi tăm tối nên huy hoàng,
	    đường lồi lõm thành những quốc lộ thẳng băng.
    }
  >>
  %\set stanza = "  ĐK:"
  \set stanza = ""
  Nào hô vang, Sa mạc cùng với thị thành,
  bao thôn ấp miền Kê -- đa du mục,
  Hò reo lên, hỡi dân cư miền núi đá,
  từ đỉnh núi hãy chung lời tụng ca.
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
    (set! all-grob-descriptions
          (cons ((@@ (lily) completize-grob-entry)
                 (cons grob-name grob-entry))
                all-grob-descriptions)))

#(add-grob-definition
   'StanzaNumberSpanner
   `((direction . ,LEFT)
     (font-series . bold)
     (padding . 1)
     (side-axis . ,X)
     (stencil . ,ly:text-interface::print)
     (X-offset . ,ly:side-position-interface::x-aligned-side)
     (Y-extent . ,grob::always-Y-extent-from-stencil)
     (meta . ((class . Spanner)
              (interfaces . (font-interface
                             side-position-interface
                             stanza-number-interface
                             text-interface))))))

\layout {
   \context {
     \Global
     \grobdescriptions #all-grob-descriptions
   }
   \context {
     \Score
     \remove Stanza_number_align_engraver
     \consists
       #(lambda (context)
          (let ((texts '())
                (syllables '()))
            (make-engraver
             (acknowledgers
              ((stanza-number-interface engraver grob source-engraver)
                 (set! texts (cons grob texts)))
              ((lyric-syllable-interface engraver grob source-engraver)
                 (set! syllables (cons grob syllables))))
             ((stop-translation-timestep engraver)
                (for-each
                 (lambda (text)
                   (for-each
                    (lambda (syllable)
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
                    syllables))
                 texts)
                (set! syllables '())))))
   }
   \context {
     \Lyrics
     \remove Stanza_number_engraver
     \consists
       #(lambda (context)
          (let ((text #f)
                (last-stanza #f))
            (make-engraver
             ((process-music engraver)
                (let ((stanza (ly:context-property context 'stanza #f)))
                  (if (and stanza (not (equal? stanza last-stanza)))
                      (let ((column (ly:context-property context
'currentCommandColumn)))
                        (set! last-stanza stanza)
                        (if text
                            (ly:spanner-set-bound! text RIGHT column))

                        (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                        (ly:grob-set-property! text 'text stanza)
                        (ly:spanner-set-bound! text LEFT column)))))
             ((finalize engraver)
                (if text
                    (let ((column (ly:context-property context
'currentCommandColumn)))
                      (ly:spanner-set-bound! text RIGHT column)))))))
     \override StanzaNumberSpanner.horizon-padding = 10000
   }
}
% kết thúc mã nguồn

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override LyricHyphen.minimum-distance = #0.8
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
