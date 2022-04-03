% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Hết Lòng Cảm Tạ" }
  composer = "Tv. 137"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8 c |
  f,4. g16 (f) |
  d4. c8 |
  a'8. bf16 a8 f |
  g g ~ g4 ~ |
  g c8 a |
  f4. g16 (f) |
  d4. c8 |
  f8. f16 e8 g |
  a8 a ~ a4 ~ |
  a a8. f16 |
  f8 bf4 bf8 ~ |
  bf g d' c |
  a2 ~ |
  a4 bf8. bf16 |
  a8 d,4 c8 ~ |
  c c g' e |
  f2 ~ |
  f4 \bar "||" \break
  
  f8. a16 |
  g8 f d4 ~ |
  d8 d f g |
  c,4. c8 |
  a'8. a16 f8 bf |
  a g ~ g4 |
  g8 bf c c |
  bf bf d (c16 bf) |
  g4 r8 e16 e |
  d8 g c, c |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8 c |
  f,4. g16 (f) |
  d4. c8 |
  f8. g16 f8 d |
  e e ~ e4 ~ |
  e c'8 a |
  f4. g16 (f) |
  d4. c8 |
  a8. a16 c8 e |
  f f ~ f4 ~ |
  f f8. d16 |
  d8 g4 g8 ~ |
  g e bf' a |
  f2 ~ |
  f4 g8. g16 |
  c,8 bf4 a8 ~ |
  a a bf c |
  a2 ~ |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Con hết lòng cảm tạ,
  vì Chúa đã nghe lời con xin,
  Trước chư vị thiên thần,
  này con xin đàn ca kính Chúa,
  Hướng về đền thánh con phục bái tôn thờ,
  Cảm mến danh Ngài,
  vì Ngài vẫn dủ thương.
  <<
    {
      \set stanza = "1."
      Mọi quốc vương trên trần đều xin cảm tạ
      vừa khi nghe lời Chúa tuyên ngôn.
      Họ đồng thanh ca ngợi đường lối Ngài,
      vinh quang Ngài vĩ đại dường bao.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dù Chúa muôn cao trọng mà luôn dủ tình
	    nhìn xem ai hèn yếu cô thân.
	    Dù con đây khi gặp hồi hiểm nghèo
	    luôn luôn được Chúa bảo toàn cho.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Kìa ác nhân xông lại sục sôi oán hờn,
	    Ngài ra tay chặn đứng đi thôi,
	    Dùng bàn tay uy quyền để khuất phục,
	    xin thương mà tế độ hồn con.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Việc Chúa thương đã làm rầy xin liễu thành,
	    vì Chúa vẫn trọn nghĩa yêu thương.
	    Mọi kỳ công tay Ngài từng khởi đầu
	    nay xin đừng lỡ bỏ dở dang.
    }
  >>
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
